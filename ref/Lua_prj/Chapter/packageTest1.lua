#!/usr/local/bin/lua
local P = {};



if _REQUIREDNAME == nil then
	packageTest1= P
else
	_G[_REQUIREDNAME] = P
end


local _G=_G; --改变环境之前保存老环境

setfenv(1,P); --使得一个package独占一个环境 ,使用这种方法将不存在私有函数,而且老环境的变量不能被直接访问

--不用加前缀也自动属于packageTest1这个包的函数
function sayHello()
	_G.print("Say hello packageTest1");
end


function sayNow()
	_G.print(" packageTest1 now I say : ")
	sayHello();--不需要加前缀访问包内函数
	_G.io.write("io.w");
end

return p;
