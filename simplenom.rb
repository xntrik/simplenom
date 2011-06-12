#!/usr/bin/ruby
# Version and licensing gumpft
#
# Version 0.1 - 12th of June, 2011 - Created by Christian "xntrik" Frichot.
#
# Copyright 2011 Christian Frichot
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 	http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Gems ahoy!
require 'rubygems'
require 'pony'

# Variables - set these!
$targetaddress = "you@here.com"
$fromaddress = "simplenom@servername.com"

# The rest is the noobesque script
cmds = ["yum check-update","yum --security check-update"] #The commands to run
outputbody = "" #This is what is put in the email

# Check the return status of the commands
def check_return
	($?.to_i.nil? or $?.to_i == 0) ? nil : true
end

# Run the commands, and add to the email body if we have to.
cmds.each { |cmd|
	s = system cmd
	outputbody += cmd + "\nSomething to do\n" if not check_return.nil?
}

# Do we have to email?
if outputbody == ""
	puts "Nope" # Nope
else
	# Yep
	Pony.mail(:to => $targetaddress, :from => $fromaddress, :subject => "Simple Nom Checker", :body => outputbody)
end
