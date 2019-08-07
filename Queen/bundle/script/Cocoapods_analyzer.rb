#!/usr/bin/env ruby
# -*- coding: UTF-8 –*-

require 'rubygems'
require 'json'
require 'yaml'
require 'pathname'
require 'fileutils'
#require 'tins/find'
require 'cocoapods'
require 'strscan'
require 'claide/command/plugin_manager'
require 'claide/ansi'


class DependencyAnalyzer
  def self.analyze(podfile_dir_path)
      path = Pathname.new(podfile_dir_path)
      raise 'absolute path is needed' unless path.absolute?

      Dir.chdir(podfile_dir_path) do
        analyze_with_podfile(
          path,
          Pod::Podfile.from_file(path + 'Podfile'),
          Pod::Lockfile.from_file(path + 'Podfile.lock')
        )
      end
    end

    def self.podfile_dependencies(podfile)
      res = []
      podfile.root_target_definitions.each do |td|
        children_definitions = td.recursive_children
        children_definitions.each do |cd|
          dependencies_hash_array = cd.send(:get_hash_value, 'dependencies')
          next if dependencies_hash_array.count.zero?

          dependencies_hash_array.each do |item|
            next if item.class.name != 'Hash'

            item.each do |name, _|
              res.push name
            end
          end
        end
      end
      res
    end

    def self.analyze_with_podfile(_podfile_dir_path, podfile, lockfile = nil)

      config = Pod::Config.instance
      config.podfile = podfile
      config.installation_root = Pathname.new(_podfile_dir_path)
      Pod::Config.instance = config

      sandbox = _podfile_dir_path + '/Pods'
      # end
      puts sandbox
      analyzer = Pod::Installer::Analyzer.new(
        Pod::Sandbox.new(sandbox),
        podfile,
        lockfile
      )

      analyzer_result = analyzer.analyze
      specifications = analyzer_result.specifications.map(&:root).uniq

      podfile_dependencies = podfile_dependencies(podfile)

      map = {}
      specifications.each do |s|
        map[s.name] = if s.default_subspecs.count > 0
                        subspecs_with_name(s, s.default_subspecs) + s.dependencies
                      else
                        s.subspecs + s.dependencies
                      end
        subspecs_in_podfile = podfile_dependencies.select { |pd| pd.split('/')[0] == s.name }
        sp = subspecs_in_podfile.map { |sip| s.subspecs.find { |ss| ss.name == sip } }.compact
        map[s.name] = sp if sp.count != 0
        s.subspecs.each do |ss|
          map[ss.name] = ss.dependencies
        end
      end

      # for performance
      dependencies_map = {}
      specifications.each do |s|
        dependencies_map[s.name] = s
      end

      new_map = {}
      specifications.each do |s|
        new_map[s.name] = find_dependencies(s.name, map, [], dependencies_map, s.name).uniq.sort
      end

      new_map
    end

    def self.find_dependencies(name, map, res, dependencies_map, root_name)
      return unless map[name]

      map[name].each do |k|
        find_dependencies(k.name, map, res, dependencies_map, root_name)
        dependency = dependencies_map[k.name.split('/')[0]]
        res.push dependency.name if dependency && dependency.name != root_name
      end
      res
    end

    def self.subspecs_with_name(spec, subspecs_short_names)
      subspecs_short_names.map do |name|
        spec.subspecs.find { |ss| ss.name.include? name }
      end
    end


    def self.to_d3js_json(_podfile_dir_path, podfile, lockfile = nil)
      json = {}
      links = []
      results = analyze_with_podfile(_podfile_dir_path, podfile, lockfile = nil)
      results.each do |node, v|
        v.each do |dependency|
          links.push(
            {
              'source': node,
              'dest': dependency,
            }
          )
        end
      end

      json['links'] = links

      JSON.pretty_generate(results)
    end


    # TODO This needs tests.
    def analyze_podfile(podfile, installation_root)
        config = Pod::Config.instance
        config.podfile = podfile
        config.installation_root = installation_root
        Pod::Config.instance = config

        puts config.sandbox
        puts config.podfile
        puts config.lockfile

        analyzer = Pod::Installer::Analyzer.new(config.sandbox, config.podfile, config.lockfile)
        analysis = analyzer.send(:inspect_targets_to_integrate).values

        user_projects = {}
        analysis.each do |target|
            user_project = user_projects[target.client_root.to_s] ||= {}
            user_targets = user_project["targets"] ||= {}
            target.project_target_uuids.each do |uuid|
                user_target = target.project.objects_by_uuid[uuid]
                user_target_info = user_targets[user_target.name] ||= begin
                    {
                        "info_plist" => user_target.resolved_build_setting("INFOPLIST_FILE").values.first,
                        "type" => user_target.product_type,
                        "platform" => target.platform.to_s,
                        "pod_targets" => [],
                    }
                end
                user_target_info["pod_targets"] << target.target_definition.label
            end
        end

        pod_targets = config.podfile.target_definitions.values.inject({}) do |h, target_definition|
            h[target_definition.label] = target_definition.dependencies.map(&:name) unless target_definition.empty?
            h
        end

        uses_frameworks = config.podfile.target_definitions.first.last.to_hash["uses_frameworks"]
        last_installed_version = config.sandbox.manifest && config.sandbox.manifest.cocoapods_version.to_s
        {
            "projects" => user_projects,
            "pod_targets" => pod_targets,
            "uses_frameworks" => uses_frameworks,
            "cocoapods_build_version" => last_installed_version
        }
    end
end


#===========================run =========================

if ARGV.count < 3
  puts "参数不够"
end
puts ARGV
puts DependencyAnalyzer.to_d3js_json(ARGV.at(1),Pod::Podfile.from_file(ARGV.at(2)))
