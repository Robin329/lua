#!/usr/local/bin/lua
--Module Demo
require "ModuleTest"
print(My.tool.EMoneyType.Gold);

function demoArgs(a1,a2,a3)
	print(a1,a2,a3)

end

demoArgs(1,100)

for k,v in pairs(package) do
	--print(k,v)
end

tab = {1,2,3,x=1}
print(#tab)
