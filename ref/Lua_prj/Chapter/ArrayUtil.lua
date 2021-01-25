#!/usr/local/bin/lua
--数组操作

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