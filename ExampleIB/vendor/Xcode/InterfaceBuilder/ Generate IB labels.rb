#!/usr/bin/env ruby

#
# Generate RM outlet and action statements from IB proxy file.
#
# Full line comments and multiple empty lines are skipped.
# indented comment lines and those after outlet and action definitions are kept.
#
# The script is meant to be placed in the same folder as the IB Objective-C files.
# Dir.glob, File.write, and path patterns will need to be (re)set if different.
#

require 'date'


output = []
count = 0
now = DateTime.now.strftime('%F %R')

Dir.glob('./*.h').each do |item|
   shorter = '../' + Dir.pwd.split('/')[-3..-1].join('/') + item[1..-1]  # not that much...
   output << "#{'#' * 50}\n# IB outlets and actions extracted #{now} from:\n# #{shorter}\n#\n"
   count += 1
   File.foreach(item) do |line|
      next if line.start_with?('//')  # skip full comments
      words = line.strip.split(/\W+/)
      here = line.strip.rpartition('//')  # keep track of partial line comments
      case
      when words.index('IBOutlet')
         comment = here.first.empty? ? '# ' : "##{here.last}"
         output << "attr.accessor :#{words.last} #{comment}\n"
      when words.index('IBAction')
         comment = here.first.empty? ? '# ' : "##{here.last}"
         output << "\n#{comment}\ndef #{words[2]}(sender)\n   # your code here\nend\n"
      when line.strip.start_with?('//')  # keep indented comments
         output << "##{here.last}\n"
      else  # keep single blank lines
         output << "\n" unless output.last == "\n"      
      end   
   end
end

File.write('./ IB Labels.rb', "#{output.join}") unless output == []
puts "Done.\nIB labels generated for #{count} Xcode project#{count > 1 ? 's' : ''}."

