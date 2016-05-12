#!/usr/bin/env ruby

def run
  if commit_message == 'hi'
    exit 0 # Commit
  end
  exit 1 # Abort
end

def commit_message
  File.open(ARGV[0]).read
end

def branch_name
  `git branch | grep "^\*"`[2..-1]
end

# run


