--第十三章
--Metatable Metamethed

require "CommonFunc"

--利用 +运算符执行集合并操作
Set={};

Set.mt={};

function Set.new(t)
	local set = {}
	setmetatable(set,Set.mt);
	for _,l in ipairs(t) do set[l] = true end
	return set;
end

function Set.union(a,b)
	local res = Set.new{};

	for k in pairs(a) do res[k] = true end;
	for k in pairs(b) do res[k] = true end;

	for i in pairs(res) do
		print("union i=",i,res[i])
	end

	return res;
end

function Set.tostring(set)
	local s = "{"
	local sep = ""
	for e in pairs(set) do
		s = s .. sep .. e
		sep = ", "
	end
	return s .. "}"
end

function Set.print(s)
	print(Set.tostring(s));
end



--这时候利用Set.new创建的所有集合都有同一个metatable
s1 = Set.new{10,20,30,50};
s2 = Set.new{30,1};

print(getmetatable(s1));
print(getmetatable(s2));

Set.mt.__add = Set.union; --给metatable增加__add函数

--[[
s3 = s1 + s2;

Set.print(s3);

--]]


--[[
对于每一个算术运算符，metatable都有对应的域名与其对应，除了__add,__mul外，
还有__sub(减),__div(除),__unm(负),__pow(幂)，
我们也可以定义__concat定义连接行为�
-]]


--集合的算术操作

--[[

__eq（等于），__lt（小于），和__le（小于等于）给关系运算符赋予特殊的含义


--]]

--小于等于
Set.mt.__le = function (a,b)
	print('-----le----')
	for k in pairs(a) do
		if not b[k] then return false end;
	end
	return true
end

--大于和小于
Set.mt.__lt = function (a,b)
	print('-----lt----')
	return a <=b and not (b<=a)
end

--等于
Set.mt.__eq = function (a,b)
	print('-----eq----')
	return a <= b and b<=a
end


s1 = Set.new{2, 4}
s2 = Set.new{4, 10, 2}
--print(s1 <= s2) --> true
--print(s1 < s2) --> true
--print(s1 >= s1) --> true
--print(s1 > s1) --> false
print(s1 == s2) --> false


--print(s1 == s2 * s1) --> true

Window = {};

Window.mt={}; --metatable

--窗口的原型
Window.prototype = {x=0,y=0,width=100,height=100};

function Window.new(o)
	setmetatable(o,Window.mt);

	return o;
end;

--定义index metatable
Window.mt.__index = function (tab,key)

	return Window.prototype[key];
end;

w = Window.new{x=10,y=20};
print(w.width); -- w不存在width域 lua就会通过__index域的metatable访问 __index metamethod获取缺少的域


--改变默认值

print("----------改变默认值-----------")

function setDefault(t,d)
	local mt = {__index = function () return d end}
	setmetatable(t,mt);
end

tab1 = {x=10,y=20}

print(tab1.x,tab1.z);
--Global.PrintTabKV(tab1)

setDefault(tab1,0);


print(tab1.x,tab1.z);

setDefault(tab1,100);


print(tab1.x,tab1.z);

--监控表

print("-------------------++++++监控表++++++----------------");

t = {};
local _t = t;

t = {};
--通过metatable的__index域和__newindex分别监控 t的 访问和修改 操作
local mt = {

	--访问默认值
	__index = function (t,k)
		print("*access to element " .. tostring(k))
		return _t[k];
	end
	,
	--更新默认值
	__newindex = function (t,k,v)
		print("*update of element " .. tostring(k) .. " to " .. tostring(v))
		_t[k]=v;
	end

}

setmetatable(t,mt);

--t[2] = "hello"; --调用__newindex域

--print(t[2]) --调用__index域

-- +++++++++++++++++++++++ 改进后的监控表操作

print("-- +++++++++++++++++++++++ 改进后的监控表操作")

local index = {};

t2 = {};

local mt2 = {

	--访问默认值
	__index = function (t,k)
		print("*access to element " .. tostring(k))
		return t2[k];
	end
	,
	--更新默认值
	__newindex = function (t,k,v)
		print("*update of element " .. tostring(k) .. " to " .. tostring(v))
		t2[k]=v;
	end

}


function track(t)
	local proxy = {};
	proxy[index] = t2;
	setmetatable(proxy,mt2)
	return proxy

end


index = track(index);

index[3] = "aa";
print(index[3])

newTab={};

newTab=track(newTab)
newTab[3]="2222";
print(newTab[3])

print(index[3])

--创建只读表 , 因为修改表主要系通过其__newindex域修改，所以我们只需在__newindex域抛出错误即可

print("+++++++++--返回一个只读表++++++++++")
--返回一个只读表
function readyOnly(t)
	local proxy={};
	local mt = {
		__index=t;
		__newindex=function (t,k,v)
			error("attempt to update a ready-only table",2);
		end
	}
	setmetatable(proxy,mt);
	return proxy;

end

days=readyOnly{"Sunday","Monday","Tuesday","Wednesday"};

print(days[1])
days[2] = "Noday"; --抛出错误




