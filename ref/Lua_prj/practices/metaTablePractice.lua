print("metaTablePractice..")

func = function ( ... )
	print("Hello",arg.n)
end

func(1,23)

Student = {}
Student.mt = {sex=1,name=""}

function  Student.new()
	local stu = {from="广州"} 
	setmetatable(stu,Student.mt)
	return stu
end

Student.mt.__index = function (t,key) --设置__index 域实现继承关系
	for k,v in pairs(t) do
		print('k,v',k,v)
	end 
	return Student.mt[key]
end

stu = Student.new()
print(stu.sex)

--监控表,访问了表的哪些属性和设置了哪些值

function setDefault(t,d)
	local  mt = {__index=function ( )
		return d
	end }
	setmetatable(t,mt)
end


t1 = {}
_t1 = t1

t1 = {}
local mt1 = {
__index = function (t,k)
	print("访问了 ",k)
	return _t1[k]
end,
__newindex = function (t,k,v)
	print("设置了",k,"的值为",v)
	_t1[k] = v
end
}

setDefault(t1,"123-321")
--setmetatable(t1,mt1)

t1[123] = "hello"

print(t1['age'])




