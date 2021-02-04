#!/usr/local/bin/lua

-- 1. input function
print(">>>>>>>>>>>>>>>> 1. input FUN<<<<<<<<<<<<<<<\n")

print("---------test1---------\n")
-- lua 输入参数，计算某个整数的阶乘

function fact (n)
	if n==0 then
		return 1
	else
		return n*fact(n-1)
	end
end

-- print ("请输入整数：")
-- io.write("input int:")
-- a = io.read("*num")
-- a = io.read()
-- print (tostring(a).."的阶乘是：".. fact(a))

local file1 = io.input("/Users/renbinjiang/workspace/project/lua/others/test.txt")
--print(file1:read("*a"))
io.input(file1)
local lines = {}
for line in io.lines() do
	table.insert( lines, line ) -- 在每行前面创建行号
end
print("== reade lines ==")
for k,v in pairs(lines) do
	print("k = " .. k .. " v = " .. v)
end
file1:close()


print("---------test2---------\n")


-- 2. open file
-- ref:https://www.cnblogs.com/chiguozi/p/5804951.html

-- "*n": 从文件当前位置读入一个数字，如果该位置不为数字则返回 nil。
-- "*l": 读入当前行。
-- "*a": 读入从当前文件指针位置开始的整个文件内容。

local file = io.open("/Users/renbinjiang/workspace/project/lua/others//test.txt", "r")
print("1 ==>")
print(file:read("*a"))
print("2 ==>")
print(file:read("*l"))
print("3 ==>")
print(file:read("*n"))

print("4 ==>")
for line in io.lines("/Users/renbinjiang/workspace/project/lua/others//test.txt") do
    print(line) --默认读取一行
end
print(file:lines("*a"))
file:close(file)

print("5 ==>")
local file3 = io.open("/Users/renbinjiang/workspace/project/lua/others/num.txt")
io.input(file3)
for line in io.lines("/Users/renbinjiang/workspace/project/lua/others/num.txt") do
	print(line)
	local m, n, i = io.read("*n", "*n", "*n")
	if m == nil then
		return
	end
	print("max = " .. math.max( m, n, i)) -- 打印最大值
	print("random = " .. math.random( 1,1000)) -- 打印1 - 1000随机值
end
io.close(file3)


-- 3. write file
print("---------test3---------\n")
io.write("123", "56", "\n")
local file2 = io.open("/Users/renbinjiang/workspace/project/lua/others//test.txt", "a+")
file2:write("\nwrite file\n") -- 在文件末尾追加
io.output(file2)
io.write("\n1234")
print(io.type(file2))

print("== create tmp file ==")
local tmpfile = io.tmpfile()
print(io.type(tmpfile))

io.close(file2)



-- 3. 计算file size

function fsize(file)
	local cur = file:seek() --获取当前位置
	local size = file:seek("end") -- 获取文件大小
	file:seek("set", cur) --恢复原有的当前位置
	return size
end

local file4 = io.open("/Users/renbinjiang/workspace/project/lua/others//test.txt", "r")
print("6 ==>")
print(fsize(file4))


-- 4. os function
print("7 ==>")
local date = os.date()
print(date)

print("8 ==>")

-- 延时函数1：ms
-- Solution: os.execute(...)
function msleep(n)
	print("delay " .. n .. "ms")
	os.execute("sleep " .. tonumber(n / 1000))
end
-- 延时方式2：s
-- Solution: os.time()
function sleep1(s)
	local ntime = os.time() + s
	repeat until os.time() > ntime
end

-- 延时函数3：s
-- Solution: os.clock()
function sleep2(s)
	local ntime = os.clock() + s
	repeat until os.clock() > ntime
end


print("sleep1 ")
msleep(1000)
print("sleep2 ")
sleep1(2)
print("sleep3 ")
sleep2(3)


print("9 ==>")


--[[
ref: https://www.lua.org/pil/22.1.html
%a	abbreviated weekday name (e.g., Wed)
%A	full weekday name (e.g., Wednesday)
%b	abbreviated month name (e.g., Sep)
%B	full month name (e.g., September)
%c	date and time (e.g., 09/16/98 23:48:10)
%d	day of the month (16) [01-31]
%H	hour, using a 24-hour clock (23) [00-23]
%I	hour, using a 12-hour clock (11) [01-12]
%M	minute (48) [00-59]
%m	month (09) [01-12]
%p	either "am" or "pm" (pm)
%S	second (10) [00-61]
%w	weekday (3) [0-6 = Sunday-Saturday]
%x	date (e.g., 09/16/98)
%X	time (e.g., 23:48:10)
%Y	full year (1998)
%y	two-digit year (98) [00-99]
%%	the character `%´
]]
print("\n os.clock example :\n");
-- 记录开始时间
local starttime = os.clock();                           --> os.clock()用法
print(string.format("start time : %.4f", starttime));

-- 进行耗时操作
local sum = 0;
for i = 1, 100000000 do
      sum = sum + i;
end

-- 记录结束时间
local endtime = os.clock();                           --> os.clock()用法
print(string.format("end time   : %.4f", endtime));
print(string.format("cost time  : %.4f", endtime - starttime));

print(os.date("today is %A, in %B"))
print(os.date("%x", 906000490))