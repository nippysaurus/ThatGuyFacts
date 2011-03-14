require 'csv'

if ARGV.length == 0 then raise "no file specified" end

filepath = ARGV[0]

if FileTest.exist?(filepath) == false then raise "file not found" end

#values = CSV.read(filepath, headers: false)
values = CSV.read(filepath)

$facts = { 1 => [], 2 => [], 3 => [], 4 => [], 5 => [] }

puts values.class
puts $facts.class

values.each { |bla|
    if (bla[0].to_i == 0) then next end
    $facts[bla[0].to_i].push(bla[1])
    }

#puts "1 count = #{$facts[1].length}"
#puts "2 count = #{$facts[2].length}"
#puts "3 count = #{$facts[3].length}"
#puts "4 count = #{$facts[4].length}"
#puts "5 count = #{$facts[5].length}"

# ratio of this level to the one above it
$ratio = { 1 => 0.0, 2 => 0.0, 3 => 0.0, 4 => 0.0, 5 => 1.0 }

$ratio[5] = (1).to_f
$ratio[4] = ($facts[4].length.to_f / $facts[5].length.to_f).to_f
$ratio[3] = ($facts[3].length.to_f / $facts[4].length.to_f).to_f
$ratio[2] = ($facts[2].length.to_f / $facts[3].length.to_f).to_f
$ratio[1] = ($facts[1].length.to_f / $facts[2].length.to_f).to_f

#puts "5 ratio = #{$ratio[5]}"
#puts "4 ratio = #{$ratio[4]}"
#puts "3 ratio = #{$ratio[3]}"
#puts "2 ratio = #{$ratio[2]}"
#puts "1 ratio = #{$ratio[1]}"

# ratio of this level relative to level 5
$ratio_from_top = { 1 => 0.0, 2 => 0.0, 3 => 0.0, 4 => 0.0, 5 => 1.0 }

$ratio_from_top[5] = ($ratio[5]).to_f
$ratio_from_top[4] = ($ratio_from_top[5].to_f * $ratio[4].to_f).to_f
$ratio_from_top[3] = ($ratio_from_top[4].to_f * $ratio[3].to_f).to_f
$ratio_from_top[2] = ($ratio_from_top[3].to_f * $ratio[2].to_f).to_f
$ratio_from_top[1] = ($ratio_from_top[2].to_f * $ratio[1].to_f).to_f

#puts "5 ratio_from_top = #{$ratio_from_top[5]}"
#puts "4 ratio_from_top = #{$ratio_from_top[4]}"
#puts "3 ratio_from_top = #{$ratio_from_top[3]}"
#puts "2 ratio_from_top = #{$ratio_from_top[2]}"
#puts "1 ratio_from_top = #{$ratio_from_top[1]}"

$Z_PK = 1
$ZID = 0

def DoLevel(level, output)

   # number of facts remaining for level
   remaining = $facts[level].length

   # how many would ideally be printed this time
   ideal = $ratio_from_top[level]

   enabled = false

   if (remaining < ideal)
      printnum = remaining
      enabled = false
   else
      printnum = ideal
      enabled = true
   end

   # print facts
   (1..printnum).each do |num|
      print level.to_s
      print " "
      (1..level).each { print "-" }
      print "|"
      fact = $facts[level].pop
      puts "#{level}: #{fact}"
      fact_number = $Z_PK
      #output << [$Z_PK, 1, 1, $ZID, "[#{level}] #{fact}"]
      #output << [$Z_PK, 1, 1, $ZID, "#{fact}"]
      output << [$Z_PK, 1, 1, $ZID, "##{fact_number} #{fact}"]
      
      $Z_PK += 1
      $ZID += 1
   end

   return enabled

end

$level_enabled = { 1 => true, 2 => true, 3 => true, 4 => true, 5 => true }

outfile = File.open('csvout', 'wb')
CSV::Writer.generate(outfile) do |output|
    #output << ['c1', nil, '', '"', "\r\n", 'c2']
    
    output << ["Z_PK", "Z_ENT", "Z_OPT", "ZID", "ZTEXT"]

    #while $level_enabled[1] == true || $level_enabled[2] == true || $level_enabled[3] == true || $level_enabled[4] == true || $level_enabled[5] == true do
    while $level_enabled[2] == true || $level_enabled[3] == true || $level_enabled[4] == true || $level_enabled[5] == true do

       $level_enabled[5] = DoLevel(5, output) if $level_enabled[5]
       $level_enabled[4] = DoLevel(4, output) if $level_enabled[4]
       $level_enabled[3] = DoLevel(3, output) if $level_enabled[3]
       $level_enabled[2] = DoLevel(2, output) if $level_enabled[2]
       #$level_enabled[1] = DoLevel(1, output) if $level_enabled[1]

    end

end
