#!/usr/bin/ruby

require "rubygems"
require "json"

output = ARGV[0]

workspaces = JSON.parse(`i3-msg -t get_workspaces`)

# save old state
focused_workspace = workspaces.find { |workspace| workspace["focused"] }

# migrate to new output
workspaces.each { |workspace|
  num = workspace["num"]
  if workspace["output"] != output then
    cmd = "i3-msg workspace #{num} && i3-msg move workspace to output #{output}"
    puts cmd
    `#{cmd}`
  end
}

# restore previous setting
cmd = "i3-msg workspace #{focused_workspace["name"]}"
puts cmd
`#{cmd}`

