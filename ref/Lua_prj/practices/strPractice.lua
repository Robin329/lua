
--练习字符串操作函数

str = "Hello world Hello"

print("获取长度",string.len(str))
print("大小写转换",string.lower(str))
print("大小写转换",string.upper(str))
print("截取字符串",string.sub(str,3,5)) -- 截取下标从 3到5的字符串 包括5 返回新的字符串
print("字符串替换",string.gsub(str,'Hello','Hi',1)) --把字符串中的Hello替换成Hi 返回新的字符串和替换次数 参数 1 表示只替换1次 不传则全部替换

print("获取ascii码",string.byte("A",1))
print("ascii码转换成字符串",string.char(97))
print("格式化输出",string.format("要输出浮点数%.4f",math.pi))

startIdx,endIdx = string.find(str,"Hello")
print("查找字符串",startIdx,endIdx)

--http://blog.csdn.net/zhangxaochen/article/details/8095007
math.randomseed(tostring(os.time()):reverse():sub(1, 6)) --随机数设置随机种子很重要

print("--12",math.random(1,100))

repNum = 2
print("字符串替换",string.gsub("这是一串，cute very cute 哈哈 cute ",'cute','great',repNum)) --返回替换后的字符串和替换次数

s = "sin(3) = $[math.sin(3)]; 2^5 = $[2^5]"
for w in string.gfind(s, "%a+") do -- gfind 返回的是迭代器
 
	print("gfind",w)
end

-- 2017年9月7日11:54:48 154

function string.split(src,split)
	ary = {}
	stIdx = 1		
	i,j = string.find(src,split,stIdx)
	while i do
		s = string.sub(src,stIdx,i-1)
		table.insert(ary,s)
		stIdx = j+1
		i,j = string.find(src,split,stIdx)
	end 	
	s = string.sub(src,stIdx)
	table.insert(ary,s)
	return ary
end

function table.join(srcTab,split)
	str = ""
	for k,v in pairs(srcTab) do
		str = str .. v ..split
	end
	str = string.sub(str,1,string.len(str)-1)
	return str
end


awardStr = "10,20,30"
--print(string.find(awardStr,",",3))
ary = string.split(awardStr,",")

for k,v in pairs(ary) do
	print(k,v)
end

print(table.join(ary,";"))

str = "var name:string = 'zhou' /** 这是注释 **/ 宏37games"

i,j = string.find(str,"/%*%*.*%*%*/")
print(i,j)
print(string.sub(str,i,j)) --2017年9月8日19:19:17 171