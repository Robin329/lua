--15章 包

--Lua主要是通过表来描述package

require "packageTest"  --直接用require的文化名访问包内的函数和属性
require "packageTest1"


packageTest.sayHello(); 
packageTest1.sayNow();

local P = {};

complex = P;

--包内私有函数 通过local关键字修饰实现
local function checkComplex(c)
	if not (type(c) == "table") and tonumber(c.r) and tonumber(c.i) then
		error(" bad complex number	",3)
	end
end

function P.new(r,i)
	return {r=r,i=i}
end

function P.add(c1,c2)
	checkComplex(c1);
	checkComplex(c2);
	return P.new(c1.r+c2.r,c1.i+c2.i);
end

return complex;
