#!/usr/bin/env ruby
# -*- coding: UTF-8 –*-

require 'rubygems'
require 'pathname'
require 'cocoapods'
require 'cocoapods-search/command/search'
require 'open-uri'


class Queue_Search

  def self.search(args = [])
    _args = CLAide::ARGV.coerce(args)
    search = Pod::Command::Search.new(_args)
    puts search.instance_variable_get(:@query)
    search.ensure_master_spec_repo_exists!
#    if _args.flag?('web')
#      puts Queue_Search.web_search(search)
#    else
    puts Queue_Search.local_search(search)
#    end
  end
#  def self.web_search(search)
#    queries = search.instance_variable_get(:@platform_filters).map do |platform|
#      "on:#{platform}"
#    end
#    queries += search.instance_variable_get(:@query)
#    query_parameter = queries.compact.flatten.join(' ')
#    url = "https://cocoapods.org/?q=#{CGI.escape(query_parameter).gsub('+', '%20')}"
#    UI.puts("Opening #{url}")
#    # open!(url)
#    Executable.execute_command(:open, [url])
#  end

  def self.local_search(search)
    query_regex = search.instance_variable_get(:@query).reduce([]) { |result, q|
      result << (search.instance_variable_get(:@use_regex) ? q : Regexp.escape(q))
    }.join(' ').strip

    sets = search.sources_manager.search_by_name(query_regex, ! search.instance_variable_get(:@simple_search))

    search.instance_variable_get(:@platform_filters).each do |platform|
      sets.reject! { |set| !set.specification.available_platforms.map(&:name).include?(platform) }
    end
    result = []
    sets.each do |p|
      pod = {}
      pod[name] = p.instance_variable_names(:@name)
      sources = []
      p.instance_variable_names(:@sources).each { |s|
        source = {}
        source[name] = s.instance_variable_names(:@name)
        sources.append(source)
      }
      result.append(pod)
    end

    puts JSON.pretty_generate(sets)
  end

end

args = ARGV
args.delete(type)
puts Queue_Search.search(ARGV)
