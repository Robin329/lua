local C = {}

Car = C

local function weight() --通过local 实现私有成员
	return "2t"
end

function C.drive(speed)
	print("我以",speed,"的时速开走了")
end

C.weight = weight;

return Car