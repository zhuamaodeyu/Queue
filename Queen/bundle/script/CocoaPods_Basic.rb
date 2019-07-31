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

class CocoaPods_Basic

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

  # pod_versions(HandyJSON)
	def pod_versions(podName)
	  sources_manager.aggregate.search_by_name(podName).first.versions.map(&:to_s)
	end

  #  比较 1.3.3    1.3.4
	def compare_versions(version1, version2)
	  Pod::Version.new(version1) <=> Pod::Version.new(version2)
  end
end

#===========================run =========================

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
	puts CocoaPods_Basic.new.all_pods
when "master_source"
	puts CocoaPods_Basic.new.master_source
when "sources"
	puts CocoaPods_Basic.new.all_pod_sources
when "pod_versions" 
	if ARGV.count < 2
		puts "参数个数不够" 
		return 
	end 
	puts CocoaPods_Basic.new.pod_versions(ARGV.at(1))
when "compare_versions"
    puts CocoaPods_Basic.new.compare_versions(ARGV.at(1),ARGV.at(2))
when "installed_plugin"
  puts CocoaPods_Basic.new.installed_plugin
#when "podfile"
#  puts CocoaPods_Basic.new.podfile(ARGV.at(1))
#when "lockfile_version"
#  puts ARGV.at(1)
#  puts CocoaPods_Basic.new.lockfile_version(ARGV.at(1))
#when "analyze_podfile"
#  puts CocoaPods_Basic.new.analyze_podfile(CocoaPods_Queue.new.podfile(ARGV.at(1)), Pathname.new(File.dirname(ARGV.at(1))))
end

