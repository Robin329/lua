local P = {};



if _REQUIREDNAME == nil then
	packageTest= P
else
	_G[_REQUIREDNAME] = P
end


function P.sayHello()
	print("Say hello test");
end







return p;
