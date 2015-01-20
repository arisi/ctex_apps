#!/usr/bin/env ruby
#encoding: UTF-8

require 'optparse'
require 'yaml'
require 'pp'

options = {}
CONF_FILE='/etc/stm32.conf'

options=options.merge YAML::load_file(CONF_FILE) if File.exist?(CONF_FILE)
options=options.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

options[:build] =  "build" if not options[:build]
options[:src] =  "src" if not options[:src]
OptionParser.new do |opts|
  opts.banner = "Usage: #{$PROGRAM_NAME} [options]"

  opts.on("-v", "--[no-]verbose", "Run verbosely; creates protocol log on console (false)") do |v|
    options[:verbose] = v
  end
  opts.on("-d", "--[no-]debug", "Produce Debug dump on verbose log (false)") do |v|
    options[:debug] = v
  end
  opts.on("-f","--file fn", "file to parse") do |v|
    options[:file] = v
  end
  opts.on("-b","--build path", "path to build directory with .o files (build)") do |v|
    options[:build] = v
  end
  opts.on("-s","--src path", "path to source directory where stub.S will be created (src)") do |v|
    options[:src] = v
  end
end.parse!

retval=0
if options[:file]
  syms={}
  puts "Processing #{options[:file]}"
  `arm-eabi-objdump -t #{options[:file]}`.split("\n").each do |line|
    if line[/^(\h+)\s+(\w)\s+(\w)\s+(.+)\s+(\h+)\s+(.+)$/]
      puts ">> #{$1},#{$2},#{$3},#{$4},#{$5},#{$6}"  if options[:debug]
      syms[$6]= {
        addr: $1.to_i(16),
        type: $3,
        size: $5.to_i(16)
      }
    else
      puts " Strange line: #{line}" if options[:debug]
    end
  end
  if options[:debug]
    syms.sort_by { |k, v | v[:addr] }.each do |sym,data|
      printf "%08X %08X %s\n",data[:addr],data[:size],sym
    end
  end
  req=[]
  puts "Checking Undefined Functions at '#{options[:build]}/*.o'..."
  `arm-eabi-objdump -t #{options[:build]}/*.o|grep UND`.split("\n").each do |line|
    if line[/^(\h+)\s+(\*UND\*)\s+(\h+)\s+(.+)$/]
      puts ">> #{$1},#{$2},#{$3},#{$4}" if options[:debug]
      req<<$4
    else
      puts " Strange line: #{line}" if options[:verbose]
    end
  end

  if options[:debug]
    syms.sort_by { |k, v | v[:addr] }.each do |sym,data|
      printf "%08X %08X %s\n",data[:addr],data[:size],sym
    end
  end

  ofn="#{options[:src]}/stub.S"
  of=File.open(ofn, 'w')
  of.write "  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  .section stub\n\n"
  req.each do |sym|
    if syms[sym]
      addr=syms[sym][:addr]+1
      if syms[sym][:type]=='F'
        of.write "  .type #{sym},%function\n"
        of.write "  .global #{sym}\n"
        of.write "  .set #{sym},0x#{addr.to_s(16)}\n"
#        of.write "#{sym}:\n"
#        of.write "   b 0x#{addr.to_s(16)}\n\n"
      else
        of.write "  .type #{sym},%object\n"
        of.write "  .global #{sym}\n"
        of.write "  .set #{sym},0x#{addr.to_s(16)}\n"
      end
      puts "0x#{addr.to_s(16)} #{sym}" if options[:verbose]
    elsif sym[0]!='_'
      puts "Error: Missing #{sym}"
      retval=-1
    end
  end
  of.close
  puts "Created '#{ofn}'."
  puts "MISSING SYMBOLS!!!!!!!!!!!" if retval!=0
end

exit retval
