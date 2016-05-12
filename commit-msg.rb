#!/usr/bin/env ruby

def run
  abort if ticket_number_from_branch_name && !commit_message_starts_with_ticket_number
  commit
end

def commit_message_starts_with_ticket_number
  commit_message.start_with?("##{ticket_number_from_branch_name}")
end

def ticket_number_from_branch_name
  /^\d{4,}/.match(branch_name)
end

def commit_message
  File.open(ARGV[0]).read
end

def branch_name
  `git branch | grep "^\*"`[2..-1]
end

def commit
  exit 0
end

def abort
  puts "Aborting commit - commit message must start with the number of your working branch (##{ticket_number_from_branch_name})."
  exit 1
end

# run


