#!/usr/bin/env ruby
require_relative '../config/environment'

test = CLI.new
test.log_in
test.action

