#!/usr/local/bin/lua
--16章 面向对象

require "Account"

--lua中实现类,继承的概念是通过表的prototype来实现

--如果我们想b作为a的prototype,也就是想a继承b

a={};
b={age=30}

-- 实现了a继承b的操作
setmetatable(a,{__index=b}); --当访问在a中没有的域 将会在__index域(b)中查找 可视为实现了继承功能

print("a.age=",a.age) -- 30




--继承于Account
SpecialAccount = Account:new();

S = SpecialAccount:new{limit = 1000.00}; --实际系调用父类Account:new

--重写父类的方法
function SpecialAccount:withdraw(v)
	if v - self.balance >= self:getLimit() then
		error("insufficient founds")
	end
	self.balance =  self.balance - v
end

function SpecialAccount:getLimit()
	return self.limit or 0;
end


print("S.balance=",S.balance)

S:deposit(100);

print("S.balance=",S.balance)

print("SpecialAccount.balance=",SpecialAccount.balance)


--多重继承

print("--------------多重继承-----------------")

--从列表中搜索有要访问的域的表
local function search(k,plist)
	local n = table.getn(plist)
	for i=1,n do
		local v = plist[i][k]
		if v then return v end
	end

end

--创建一个继承多个表的表 (类)
function createClass(...)
	local c = {}
	setmetatable(c,{__index=function (t,k)
			return search(k,arg);
		end
	})

	c.__index=c;

	function c:new(o)
		o = o or {}
		setmetatable(o,c)
		return o;
	end
	return c;
end

NameAccount = createClass(Account,Named);

account = NameAccount:new({name="paul"})

print(account.name,account.balance)


--实现getter方法和setter方法 (闭包实现)

print("--------- 实现getter方法和setter方法 -----")

function newObject(value)
	return function (action,v)
		if action=="get" then return value
		elseif action=="set" then value = v
		else error("invalid action") end

	end
end

d = newObject(110)
print("d",d,d("get")) --110
d("set",1000)
print(d("get")) --110

















