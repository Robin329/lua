-- 21章 IO库

require "CommonFunc";
require "stringUtil";

io.input("Data1.txt");
--print(io.read("*line"));

for line in io.lines() do

	print(line)
end

io.input("data2.txt")

nums = io.read("*all");

numTab=strToArr(nums,",");

--[[

for n in string.gfind(nums,"%d+") do
	table.insert(numTab,n);
end

--]]

Global.PrintTabKV(numTab);

--完全 I/O模式

local f = assert(io.open("data3.txt","w"))

local t = f:read();

print(t)







