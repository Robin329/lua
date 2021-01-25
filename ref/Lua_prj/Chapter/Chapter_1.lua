#!/usr/local/bin/lua

--第一章
print("hello world");

--定义函数
function fact(n)

	if n == 0 then
		return 1
	else
		return n * fact(n-1)
	end
end

print("enter a number:");

--a = io.read("*number");

--print(fact(a));

--字符串
page = [[
<HTML>
<HEAD>
<TITLE>An HTML Page</TITLE>
</HEAD>
<BODY>
Lua
</BODY>
</HTML>
]]

io.write(page);

--字符串链接 ..

print(10 .. 24);

-- ²»µÈÓÚ ~=

if 10 ~= 101 then

	print("yes ........... ");
end

f = a and b; -- Èç¹ûaÎªfalse£¬Ôò·µ»Øa£¬·ñÔò·µ»Øb
f = a or b; -- Èç¹ûaÎªtrue£¬Ôò·µ»Øa£¬·ñÔò·µ»Øb



function dofile (filename)
local f = assert(loadfile(filename))
return f()
end

local file1=io.input("Mount.txt")  --读取文件
local str=io.read("*a")
--print(str)
loadstring(str)()

print(Mount)

print(_G)
for k,v in pairs(_G) do
	print(k,v)
	break
end