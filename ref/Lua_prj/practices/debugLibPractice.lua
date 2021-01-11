function foo( ... )
	-- body
end

inf = debug.getinfo(foo)

for k,v in pairs(inf) do
	print(k,v)
end
