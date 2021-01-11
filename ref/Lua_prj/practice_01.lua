print("Hello lua")

if true then
	print("Yes ")
end 

tab = {10,20,30,40,50,age=120,'Hello'}
for i,v in pairs(tab) do -- pairs 函数会遍历所有key=val ipairs则只会遍历数字键的val
	print("k,v",i,v)
end

print("table len",#tab,table.getn(tab))

str = "Hello world"

j,i = string.find(str,"wo",8)
print(j,i)
