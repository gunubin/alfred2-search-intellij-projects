#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require_relative "bundle/bundler/setup"
require "alfred"
require 'find'


Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback

  target = ARGV[0]
  query = ARGV[1]

  item = {
      :uid      => "",
      :title    => '',
      :subtitle => "intellij Project",
      :arg      => '',
      :valid    => "yes",
  }

  files = Dir.glob(target+"/**/.idea")
  files.each do |path|
    if File.directory?(path) && path.include?('.idea')
      dir = File.dirname(path)
      pname = File.basename(dir)
      item[:arg] = dir
      item[:title] = pname
      if ARGV.length > 1
        if pname.include?(query)
          item[:subtitle] = 'intellij Project query: ' + query
          fb.add_item(item)
        end
      else
        fb.add_item(item)
      end
    end
  end

  puts fb.to_xml
e