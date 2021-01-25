#!/usr/local/bin/lua
-- 第四章

for i=1,10,5 do --第一个初始值 第二个终止值 第三个自增量
	print(i);
end;

------------

if 1==1 then

print(1);

elseif 2==2 then

print(1);

else

print(1);

end;

------------


while x==0 do

end;

---------
i=0;

repeat

i=i+1;

until i==10;

print(i);

print("-----------------");

idata = false

if idata then
	print("***************** idata")
end

tab = {}

table.insert(tab,{type_i=1});
table.insert(tab,{type_i=2});
table.insert(tab,{type_i=3});






function onSorthandler(a,b)
	return a.type_i > b.type_i
end

table.sort(tab,onSorthandler) --此函数应满足以下条件: 接受两个参数(依次为a, b), 并返回一个布尔型的值, 当a应该排在b前面时, 返回true, 反之返回false.

for k,v in pairs(tab) do
	print("tab k=",k,"type_i=",v.type_i)
end


function isAS3Array()
	-- body

end


strTab = {"b","a","c"}

table.sort(strTab)


for k,v in pairs(strTab) do
	print(k,v)
end


data = "hahha,"

data,count = string.gsub(data,",$","逗号");
print(data)








