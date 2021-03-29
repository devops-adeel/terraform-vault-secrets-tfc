#!/usr/bin/env ruby

require 'json'

puts JSON.unparse(JSON.parse(File.read(ARGV[0]))).to_json
