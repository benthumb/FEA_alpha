#File.open('./data/data.tab','r') do |f1|
File.open('./data/data2001.txt','r') do |f1|

flag = 0
while line = f1.gets
     $test_array = line.split(" ")
     len = $test_array.length  
     line_start = $test_array[0] 
     
     #if  line_start =~ /1(.*)/  
     if  line_start =~ /2(.*)/  
          puts line_start 
          flag = 0
     end
     
     #if  line_start =~ /1(.*)/ && len >= 14
     if  line_start =~ /2(.*)/ && len >= 14
          puts $test_array[1,3].join(" ") 
          flag = 1
     end

     if  line_start =~ /Ja(.*)/ && flag == 0  
          puts $test_array[0,3].join(" ")
     end
end
end
