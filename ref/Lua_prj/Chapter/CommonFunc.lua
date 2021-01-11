Global={};

function Global.PrintTabKV(t)
	for i in pairs(t) do
		print("key=",i," val=",t[i])
	end

end

function Global.PrintTabK(t)
	for i in pairs(t) do
		print("key=",i)
	end

end

function Global.PrintTabV(t)
	for i in ipairs(t) do
		print("val=",i)
	end

end

