#!/usr/local/bin/lua
--stringUtil

function strToArr(s,split)
	arr = {};
	i = 0
	start = 1;
	endindex = 1
	while true do
		j,i = string.find(s,split,i+1);
		if i == nil then
			break
		else
			if i>1 then
				endindex = i-1
				local str1 = string.sub(s,start,endindex)
				if str1~=nil or str1 ~= "" then
					table.insert(arr,str1);
				end				
				start=endindex+2
			end
		end
	end
	local str2 = string.sub(s,start,string.len(s))
	if str2~=nil or str2 ~= "" then
		table.insert(arr,str2);
	end	
	return arr
end
