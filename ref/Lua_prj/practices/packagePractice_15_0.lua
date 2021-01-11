--十五章 包 
--使用表来描述package

--[[
print("Hello")
]]--


Account = {balance = 199}

function Account.withdraw (self, v)
	self.balance = self.balance - v
	
end

function Account:new(obj) --创建实例
	local  ob =obj or {}
	setmetatable(ob,self) --设置自身为新实例的metatable 实现新的table继承Account
	self.__index = self --非常重要的一部 必须设置__index域函数为self
	return ob
end



--Account.withdraw(Account,100) --点 语法调用函数需要显式传入self

a1 = Account:new()

a1:withdraw(10)
print(a1.balance)

a2 = Account:new()
print(a2.balance)

require "oop"

SubAccount = createClass(Account)
function SubAccount:init() --覆盖父类的初始化函数	
	print("111")
end

sa = SubAccount:new()

print(sa.balance)