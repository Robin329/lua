--14章 环境 也就是lua中的环境变量

require "CommonFunc";

--打印出当前环境中的所有全局变量

abc = "你好吗 boy";

--Global.PrintTabKV(_G); -- _G保存着当前环境中的所有全局变量


--创建一个多层表

function setField(f,v)
	local t = _G;
	for w,d in string.gfind(f,"([%w_]+)(.?)") do
		if d == "." then
			t[w]= t[w] or {};
			t = t[w];
		else
			t[w] = v;
		end
	end
end

setField("t.x.y",10)

print(t.x.y)

a = 1

setfenv(1,{});

print(a); --抛错







