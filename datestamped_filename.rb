#!/usr/bin/env ruby -w

#
# datestamped_filename - Renames files so that the creation date is in the filename
# Copyright (C) 2012 gw111zz 
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#

require 'date'
require 'fileutils'
require 'optparse'
require 'time'

Options = {}

option = OptionParser.new do |op|
    op.banner = "$0 <options> <filename(s)>"
    op.separator ''

    op.on("-p", "--prefix PREFIX", "Text that should appear before date") do |prefix|
        Options[:prefix] = prefix       
    end

    op.on("-o", "--postfix POSTFIX", "Text that should appear after date") do |postfix|
        Options[:postfix] = postfix       
    end

    op.on("-r", "--really-rename", "Really renamed the files. Without this option, program will just print out what the renames will be") do
        Options[:really_rename] = true       
    end

    op.on("-h", "--help", "Rename file with creation time. For example: ruby $0 -p \"Holiday-\" *.jpg will rename all jpg to Holiday-2012-01-01-XXX.jpg") do 
        puts op
        exit 
    end
end

option.parse!(ARGV)

# ARGV now contains a list of the file names
ARGV.each do |file|
    next unless File.exists? file
    date = File.ctime(file).to_date 
    new_name = "#{Options[:prefix]}#{date.strftime("%Y-%m-%d")}#{Options[:postfix]}#{file}"
    $stdout.puts "#{file} -> #{new_name}"
    if !Options[:really_rename]
        FileUtils.mv file, new_name
    end
end



