# -*- coding: UTF-8 –*-

require 'rubygems'
require 'json'
require 'yaml'
require 'pathname'
require 'fileutils'
require 'tins/find'
require 'cocoapods'
require 'strscan'
require 'claide/command/plugin_manager'
require 'claide/ansi'

CLAide::ANSI.disabled = true

class CocoaPods_Queue  

	def sources_manager
	  Pod::Config.instance.sources_manager
	end

	def all_pods
	  sources_manager.aggregate.all_pods
	end

  def installed_plugin 
    CLAide::Command::PluginManager.installed_specifications_for_prefix("cocoapods")
  end

	def master_source
	  sources_manager.master
	end

	def all_pod_sources
	  sources_manager.all.map { |source|
	    { source.name => source.url }

	  }.reduce &:merge
	end
  # Podfile path /xxx/xxx/Podfile
  def podfile_s(path)
   File.open(path, 'r:utf-8', &:read)
  end 

  def podfile(path)
    podfile = Pod::Podfile.from_file(path)
  end

  # pod_versions(HandyJSON)
	def pod_versions(podName)
	  sources_manager.aggregate.search_by_name(podName).first.versions.map(&:to_s)
	end

  # lockfile path /ddddd/dddd/ddd/Podfile.lock
	def lockfile_version(path)
	  lockfile = Pod::Lockfile.from_file(path) 
    if lockfile != nil 
      lockfile.cocoapods_version.to_s
    end 
	end

  #  比较 1.3.3    1.3.4
	def compare_versions(version1, version2)
	  Pod::Version.new(version1) <=> Pod::Version.new(version2)
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

types = Array[
  "sources",
  "all_pods",
  "master_source",
  "pod_versions",

  "lockfile_version",
  "compare_versions",
  "analyze_podfile",
  "installed_plugin",
  "DependencyAnalyzer",
  "podfile",
  "search"
]


type = ARGV.first 
if !types.include?(type)
	puts "type faild, please user"
end 


case type

when "all_pods"
	puts CocoaPods_Queue.new.all_pods
when "master_source"
	puts CocoaPods_Queue.new.master_source
when "sources"
	puts CocoaPods_Queue.new.all_pod_sources
when "pod_versions" 
	if ARGV.count < 2
		puts "参数个数不够" 
		return 
	end 
	puts CocoaPods_Queue.new.pod_versions(ARGV.at(1))
when "compare_versions"
    puts CocoaPods_Queue.new.compare_versions(ARGV.at(1),ARGV.at(2))
when "installed_plugin"
  puts CocoaPods_Queue.new.installed_plugin
when "podfile"
  puts CocoaPods_Queue.new.podfile(ARGV.at(1))
when "lockfile_version"
  puts ARGV.at(1)
  puts CocoaPods_Queue.new.lockfile_version(ARGV.at(1))
when "analyze_podfile"
  puts CocoaPods_Queue.new.analyze_podfile(CocoaPods_Queue.new.podfile(ARGV.at(1)), Pathname.new(File.dirname(ARGV.at(1))))
end

