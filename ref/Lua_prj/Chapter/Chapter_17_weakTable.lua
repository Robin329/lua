--第十七章 weak表

--创建weak table
a = {};
b = {};

setmetatable(a,b); --

b.__mode= "k"  --b是a的weak table b的__mode域有字符串 k 所以属于 weak keys类型的weak table

key = {};
a[key] = 1;

key = {};
a[key] = 2
collectgarbage(); --强制回收

for k,v in pairs(a) do print(v,k) end


--记忆函数

local results = {};
setmetatable(results,{__mode="kv"}); --设置弱表,让垃圾回收器回收当前时间内没有被使用的结果
function mem_loadString(s)

	if results[s] then
		return results[S];
	else
		local res = loadstring(s);
		results[s] = res;
		return res;
	end
end

--利用weak table设置默认值

local defaults= {};
setmetatable(defaults,{__mode="k"});
local mt = {__index = function (t) return defaults[t] end};
function setDefault(t,d)
	defaults[t] = d;
	setmetatable(t,mt);
end

--利用weak table和记忆函数设置默认值

local metas = {}

setmetatable(metas,{__mode = "v"});

function setDefault2(t,d)
	local mt = metas[d]
	if mt == nil then
		mt = {__index = function () return d end};
		metas[d]=mt;
	end
	setmetatable(t,mt);
end





