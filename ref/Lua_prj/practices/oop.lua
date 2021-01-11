
--所有类都是table

--实现继承的另外一种写法 可以实现多继承

local function search(k,plist) --在所有继承列表中查找
	local len = table.getn(plist)
	for i=1,len do
		local v = plist[i][k]
		if v then return v end
	end
end

function createClass(...) --该方法主要是创建一个类
	local cls ={}

	-- 设置类的metatable ,这样就继承了传入的所有父类的属性和方法
	setmetatable(cls,{__index = function (t,k)
		return search(k,arg) --返回传入的父类列表中的属性值
	end}) --创建类结束

	--创建类的构造函数,构造函数是产出实例(新建一个table) 实例的metatable就是类自身 
	function cls:new(obj)
		obj = obj or {}
		setmetatable(obj,self) --设置自身为新的实例的metatable
		self.__index = self --设置self的__index域为自身
		obj:init()
		return obj
	end

	function cls:init() --默认执行初始化函数
		
	end
	
	return cls

end

-- 2017年9月5日22:57:15 138页