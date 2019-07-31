#!/usr/bin/env ruby
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

class CocoaPods_Podfile

	def sources_manager
	  Pod::Config.instance.sources_manager
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

