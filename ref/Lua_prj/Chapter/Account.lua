
local P ={balance=0};


if _REQUIREDNAME == nil then
	Account= P
else
	_G[_REQUIREDNAME] = P
end

--将会返回一个继承Account的表
function P:new(o)
	o = o or {};
	setmetatable(o,self);
	self.__index = self
	return o
end

--取款
function P:withdraw(v)

	if v > self.balance then
		error("insufficient funds")
	end
	self.balance = self.balance-v;
end

--存款
function P:deposit(v)

	self.balance = self.balance + v;

end

return P
