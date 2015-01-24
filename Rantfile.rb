#! /usr/bin/env ruby
#encode : UTF-8
import "autoclean"
import "c/dependencies"
import "command"

sys.rm_f "bin/appi"
sys.rm_f "bin/appi.srec"

sys.rm_f "compile.err"
sys.touch "compile.err"

var :CFLAGS => "-g -Wall -Wfatal-errors -Wno-char-subscripts -O1 -std=gnu99  -mcpu=cortex-m3 -mthumb -mfloat-abi=soft"

libs=[]
mods=[]

incdir_gen=""; libs.each {|d|incdir_gen.concat "-I src/lib/#{d} " }
depdir_gen=["src/"]
libs.each { |d|depdir_gen << "src/lib/#{d}" }

kernel="../ctex"

defines=IO.read("#{kernel}/build/sol_STM32L_mg11/defines")
includes=IO.read("#{kernel}/build/sol_STM32L_mg11/includes")

includes.split(" ").each do |i| #add kernel path
  if i!="-I"
    i="#{kernel}/#{i}"
  end
  incdir_gen+="#{i} "
end

gen C::Dependencies, :search => depdir_gen

SRC = FileList["src/*.c"]
ASM = FileList["src/*.S"]

BUILD_DIR = "build/"
gen Directory, BUILD_DIR

LIBGCC=`arm-eabi-gcc  #{defines}  -print-libgcc-file-name`.gsub(/\n/,'')

if false
  puts "mods: #{mods}"
  puts "libs: #{libs}"
  puts "incdir: #{incdir_gen}"
  puts "LIBGCC: #{LIBGCC}"
  puts "defines: #{defines}"
end

task :default => :link do
  sys "ls -l bin/"
end

SRC.each do |source|
  target = File.join(BUILD_DIR, source.sub(/.c$/, '.o').gsub(/\//,'_'))
  gen Command, target => source do |t|
    "arm-eabi-gcc -c -o #{t.name}  #{defines} #{incdir_gen} #{t.source} 2>#{t.name}.err"
  end
  task :link => target
end

ASM.each do |source|
  target = File.join(BUILD_DIR, source.sub(/.S$/, '.o').gsub(/\//,'_'))
    gen Command, target => source do |t|
      "arm-eabi-as -c -o #{t.name}  #{t.source}"
    end
  task :link => target 
end

task :link  do
  sys "./elfsyms.rb -v -f ../ctex/bin/sol_STM32L_mg11 |tee >build/elfsyms.err"
  sys  "cd #{BUILD_DIR}; arm-eabi-ld -M -EL --cref -Map mapfile -T ../linker.ld --no-undefined -o ../bin/appi *.o 2>linker.err && arm-eabi-objcopy -O srec ../bin/appi ../bin/appi.srec "
end

require "pp"
begin
  gen Action do
    source "c_dependencies"
  end
rescue => e
  pp e
  pp e.backtrace
end

gen AutoClean, :clean


