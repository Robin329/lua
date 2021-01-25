#!/usr/local/bin/lua



--多字段排序:返回true表示v1在v2前面

local fields = {"power","lv","timev","hh"}

function sortByField(v1,v2)

	local flag =false
	local index = 1

	--默认升序排列
	if v1[fields[index]] < v2[fields[index]] then
		flag = true
	else
		while v1[fields[index]] == v2[fields[index]] do
			index = index + 1
			if index > #fields then
				break
			end
			local field = fields[index]

			if v1[field] < v2[field] then
				flag = true
				break
			end
		end
	end

	return flag
end

--[[
根据数组元素的多个字段排序
@params list
@params fields  排序的字段数组
@params order   DESC(降序) ASC(升序,默认) 忽略大小写
--]]
function table.sortOn(list,fields,order)

	local function sortByFieldsFunc(v1,v2)
		local flag =false


		local index = 1
		--默认升序排列
		if v1[fields[index]] < v2[fields[index]] then
			flag = true
		else
			while v1[fields[index]] == v2[fields[index]] do
				index = index + 1
				if index > #fields then -- #数组名 表示获取数组长度
					break
				end
				local field = fields[index]

				if v1[field] < v2[field] then
					flag = true
					break
				end
			end
		end

		if order ~= nil and type(order) == "string" then
			order=string.lower(order)
			if order == "desc"  then
				flag = (not flag)
			end

		end

		return flag

	end

	table.sort(list,sortByFieldsFunc)

end




--默认降序
function sortByVal(v1,v2)

	local flag =false
	if v1.power == v2.power then

		if v1.lv > v2.lv then
			flag = true
		end
	elseif v1.power > v2.power then
		flag = true
	end

	return flag
end


testTab = {
{id=1,name="z",power=100,lv=22,timev=10},
{id=2,name="d",power=90,lv=23,timev=8},
{id=3,name="a",power=100,lv=21,timev=12},
{id=4,name="b",power=110,lv=21,timev=16},
{id=5,name="c",power=110,lv=21,timev=15}
}


--table.sort(testTab,sortByField)  --sortByField sortByVal
fields = {"name","power","lv","timev","hh"}
table.sortOn(testTab,fields,"asc")


print("DESC= ",string.lower("DESC"),type("desc"),"\n")

testTab = {4,52,1,86,6,5}
table.sort(testTab)
for k,v in pairs(testTab) do

	--print("testTab k=",k,"v.id=",v.id)
	print("testTab k=",k,"v=",v)

end



--[[

tab11 = {}
tab22 = tab11
tab22[1] = {id=1}
tab22[2] = {id=2}
for k,v in pairs(tab11) do

	--print("tab11 k=",k,"v.id=",v.id)

end


nubTab = {}
print("\n rm = ",rm)
table.insert(nubTab,"a")
table.insert(nubTab,"b")
table.insert(nubTab,"c")
table.insert(nubTab,"d")

for k,v in pairs(nubTab) do

	print("nubTab 11 k=",k,"v=",v)

end

local rm = table.remove(nubTab,1)
print("\n rm = ",rm )

for k,v in pairs(nubTab) do

	print("nubTab 22 k=",k,"v=",v)

end


--]]

--[[
function split(str, delimiter)
    if (delimiter=='') then return false end
    local pos,arr = 0, {}
    -- for each divider found
    for st,sp in function() return string.find(str, delimiter, pos, true) end do
		local v=string.sub(str, pos, st - 1)
		if v ~= "" then
			table.insert(arr,v)
		end

        pos = sp + 1
    end
	local last = string.sub(str, pos)
	if last and last~="" then
		table.insert(arr, last)
	end
	if last=="" then
		print("---------最后一个是空字符串--------")
	end
    return arr
end

local str = ":ymd"



local strtab = split(str, ":")
print("--------------string---------------- ",#strtab," string.lower()= ",string.lower(str))


if string.find(str, "%L") then

local i,j=string.find(str, "%L")
local find = string.sub(str,i,j)

print("----------找到------------find=",find)

end


local pos = 0
for i=1,string.len(strtab[1]) do
	local s= string.sub(strtab[1],i,i)
	pos = pos+1
	print("i,s,pos=",i,s,pos)

end

function toint(v)
	return math.floor(tonumber(v))
end

function getDateInfoBySec(second)
	local dateTab={
		year=0,
		month=0,
		day=0,
		hour=0,
		min=0,
		sec=0,
	}

	local minSec = 60
	local hourSec = 3600
	local daySec = hourSec*24
	local monSec = daySec*30
	local yearSec =monSec*12

	dateTab.year = toint(second/yearSec)
	local leftMs = second%yearSec
	print("leftMs=",leftMs,yearSec)
	dateTab.month = toint(leftMs/monSec)
	local leftDs = leftMs%monSec
	print("leftDs=",leftDs,monSec)
	dateTab.day = toint(leftDs/daySec)

	local leftHs = leftDs%daySec
	print("leftHs=",leftHs,daySec,dateTab.day)
	dateTab.hour = toint(leftHs/hourSec)
	local leftminS = leftHs%hourSec
	dateTab.min = toint(leftminS/minSec)
	dateTab.sec = toint(leftminS%minSec)


	return dateTab
end

getDateInfoBySec(3600*24-1)

--]]







