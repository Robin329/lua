
require "CommonFunc"

--18 章 math

print("--------------math库---------------");

radVal = math.rad(90); --角度转弧度

print(radVal);

degVal = math.deg(1.5); --弧度转角度

print(degVal);


-- 19章 table库

print("--------------table库---------------");

-- 设置和获取长度

tab1 = {1,2,4,x=100,y=200,89,"abc"};

print(table.getn(tab1));--得到 5 键值对的不算入长度



--table.setn(tab2,5) --该函数在新版本中已经不能使用了

tab2={1,500,20};

print(table.getn(tab2))


table.insert(tab2,100); --在数组的最后插入一个元素
table.insert(tab2,2,800); --在数组的第二个位置插入一个元素

print("tab2=",table.getn(tab2)) --是 0 注意不要隔着下标插入元素 不然获取到的长度有误


Global.PrintTabKV(tab2);

table.remove(tab2,2) --删除第二个位置的元素

table.remove(tab2);--删除最后一个元素

print("------------------------")

table.sort(tab2); --默认是升序排列

Global.PrintTabKV(tab2);
print("-------------++++***+++++-----------")

tab3 = {"a",10,56,x=10,78,y=101};

for i in pairs(tab3) do  --遍历出整个table

	print(i,tab3[i])
end

print("-------------++++** ipairs *+++++-----------")

for j,k in ipairs(tab3) do --只遍历数组部分的元素

	print(j,k)
end

print("-------------++++** tttttt *+++++-----------")

tab4 = {200,1,50,50,90,6,4,70};

table.sort(tab4,cal); --排序函数设置升序和降序

Global.PrintTabKV(tab4);

function cal(v1,v2)
 return v1>v2 --大于号 是降序 小于号升序
end

-- 20章 string库

print("~~~~~~~~~~~~~~~~ 20章 string库 ~~~~~~~~~~~~~~~~~~~~~~ !!!")

--获取长度

str1 = "hello world";

len1 = string.len(str1);

print(len1)

print(string.sub(str1,3,5)); --截取第三到第五个字符串
print(string.sub(str1,3,-2));

print(string.char(97,98)) --返回多个ascii码对应的字符串

print(string.byte("abc",3)) --返回字符串的ascii码 默认返回第一个


--格式化字符串
print(string.format("PI = %.4f",math.pi)); --小数点后面保留四位

print(string.format("n=%o",18))

--字符串查找

str2 = "hello,world";

i,j,v =string.find(str2,",",0,true); --从第二个位置开始搜索 返回字符串的开始位置和结束位置 没有匹配返回nil

print("i,j,v=",i,j,v)

print(string.sub(str2,i,j));

--替换字符串
print(string.gsub(str2,"l","GG",2)) --第三个参数表示限制替换的次数 2 表示只替换前面两个匹配的串

str3 = "a55|||a8y5fdsd444d0"

print(string.gsub(str3,"%z","*+"))

pair = "name = Anna"
a,a2,key, value = string.find(pair, "(%a+)%s*=%s*(%a+)")
print(key, value,a,a2) --> name Anna

--去除字符串首位的空格
function trim(s)
	return (string.gsub(s,"%s*(.-)%s*$","%1"))
end







