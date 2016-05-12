#!/usr/bin/env ruby

def run
  return commit_message
end

def commit_message
  File.open(ARGV[0]).read
end

run


