#!/usr/local/bin/lua

local P ={balance=0};


if _REQUIREDNAME == nil then
	Named= P
else
	_G[_REQUIREDNAME] = P
end

function Named:setname()
	return self.name or "";
end

function Named:getname(n)
	self.name = n
end


return Named;
