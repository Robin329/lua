-- 23章  debug lib

require "CommonFunc"

function foo()
	print("this is a function call foo")
end

t=debug.getinfo(foo)
Global.PrintTabKV(t)

print(debug.traceback('nihao'))




function getvarvalue(name)

	local value,found

	local i = 1
	while true do
		local n,v = debug.getlocal(2,i);
		if not n then break end
		if n == name then
			value = v
			found = true
		end
		i = i +1;
	end

	if found then return value end

	local func = debug.getinfo(2).func
	i = 1
	while true do
		local n,v = debug.getupvalue(func,i)
		if not n then break end;
		if n == name then return v end
		i = i+1
	end
	return getfenv(func)[name]
end

testTab = {1,5,6,8}

print("绝对值 = ",10-100)
print("绝对值 = ",math.abs(10-100))


for i=1,10 do
	print("随机数 = ",math.random(1,5))
	if i==5 then
		break
	end
end















