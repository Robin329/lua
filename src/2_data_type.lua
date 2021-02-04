#!/usr/local/bin/lua
-- Lua 是动态类型语言，变量不要类型定义,只需要为变量赋值。
-- 值可以存储在变量中，作为参数传递或结果返回。
--
-- Lua 中有 8 个基本类型分别为：nil、boolean、number、string、userdata、function、thread 和 table。
--
-------------------------
-- 数据类型	描述
-- nil	这个最简单，只有值nil属于该类，表示一个无效值（在条件表达式中相当于false）。
-- boolean	包含两个值：false和true。
-- number	表示双精度类型的实浮点数
-- string	字符串由一对双引号或单引号来表示
-- function	由 C 或 Lua 编写的函数
-- userdata	表示任意存储在变量中的C数据结构
-- thread	表示执行的独立线路，用于执行协同程序
-- table	Lua 中的表（table）其实是一个"关联数组"（associative arrays），
-- 数组的索引可以是数字、字符串或表类型。在 Lua 里，table 的创建是通过"构造表达式"来完
-- 成，最简单构造表达式是{}，用来创建一个空表。


print(type("Hello world")) -- > string
print(type(10.4 * 3)) -- > number
print(type(print)) -- > function
print(type(type)) -- > function
print(type(true)) -- > boolean
print(type(nil)) -- > nil
print(type(type(X))) -- > string

-- 1. nil
-- 对于全局变量和 table，nil 还有一个"删除"作用，给全局变量或者 table 表里的变量赋一个 nil 值，
-- 等同于把它们删掉，执行下面代码就知：
print(">>>>>>>>>>>>>>>> 1.nil <<<<<<<<<<<<<<<\n")
print("---------case 1----------")
local tab1 = {key1 = "val1", key2 = "val2", "val3"}
for k, v in pairs(tab1) do
    print(k .. " - " .. v)
end

tab1.key1 = nil
for k, v in pairs(tab1) do
    print(k .. " - " .. v)
end

print("---------case 2----------")
local tab2 = {k1 = "val1", k2 = "val2", k3 = "val3"}
for k, v in pairs(tab2) do
    print(k .. " - " .. v)
end

tab2.k1 = nil
for k, v in pairs(tab2) do
    print(k .. " - " .. v)
end

-- pairs 和 ipairs区别:
-- pairs: 迭代 table，可以遍历表中所有的 key 可以返回 nil
-- ipairs: 迭代数组，不能返回 nil,如果遇到 nil 则退出
print(">>>>>>>>>>>>>>>>1.1 pairs/ipairs<<<<<<<<<<<<<<<\n")

print("---------case 1----------\n")
local tabFiles = {[1] = "test2", [6] = "test3", [4] = "test1"}

for k, v in ipairs(tabFiles) do -- 输出"test2",在key等于2处断开
    print(k, v)
end
print("---------case 2----------\n")
local tabFiles = {[2] = "test2", [6] = "test3", [4] = "test1"}

for k, v in ipairs(tabFiles) --[[什么都没输出，为什么？因为控制变量初始值是按升序来遍历的，当key为1时，value为nil，此时便停止了遍历， 所有什么结果都没输出]] do --
    print(k, v)
end

print("---------case 3----------\n")
local tabFiles = {
    [2] = "test2",
    [6] = "test3",
    [4] = "test1"
}

for k, v in pairs(tabFiles) do --输出2 test2, 6 test3, 4 test1
    print(k, v)
end

print("---------case 4----------\n")
local tabFiles = {"alpha", "beta", [3] = "no", ["two"] = "yes"}
for i, v in ipairs(tabFiles) do --输出前三个   备注：因为第四个key不是整数
    print(i, tabFiles[i])
end
print("---------case 5----------\n")
for i, v in pairs(tabFiles) do --全部输出
    print(i, tabFiles[i])
end

print("---------case 6 start----------\n")
local tab = {[1] = "a", [2] = "b", "c", [4] = "d"}
print("==== pairs ====\n")
for i, v in pairs(tab) do -- 输出 "a" ,"b", "c"  ,
    print(i .. "-" .. tab[i])
end

print("==== ipairs ====\n")
for i, v in ipairs(tab) do -- 输出 "a" ,k=2时断开
    print(i .. "-" .. tab[i])
end
print("---------case 6 end----------\n")

-- 2. boolean（布尔）
-- boolean 类型只有两个可选值：true（真） 和 false（假），
-- Lua 把 false 和 nil 看作是 false，其他的都为 true，数字 0 也是 true:
print(">>>>>>>>>>>>>>>> 2.boolean <<<<<<<<<<<<<<<\n")
print(type(true))
print(type(false))
print(type(nil))

if false or nil then
    print("至少有一个是 true")
else
    print("false 和 nil 都为 false")
end

if 0 then
    print("数字 0 是 true")
else
    print("数字 0 为 false")
end

-- 3. number（数字）
-- Lua 默认只有一种 number 类型 -- double（双精度）类型（默认类型可以修改 luaconf.h 里的定义），以下几种写法都被看作是 number 类型：
print(">>>>>>>>>>>>>>>> 3.number <<<<<<<<<<<<<<<\n")
print(type(2))
print(type(2.2))
print(type(0.2))
print(type(2e+1))
print(type(0.2e-1))
print(type(7.8263692594256e-06))

-- 4. string（字符串）
-- 字符串由一对双引号或单引号来表示。
print(">>>>>>>>>>>>>>>> 4.string <<<<<<<<<<<<<<<\n")
local string1 = "this is string1"
local string2 = "this is string2"
print(string1)
print(string2)

-- 也可以用 2 个方括号 "[[]]" 来表示"一块"字符串。
local html = [[
<html>
<head></head>
<body>
    <a href="http://www.runoob.com/">菜鸟教程</a>
</body>
</html>
]]
print(html)

-- 在对一个数字字符串上进行算术操作时，Lua 会尝试将这个数字字符串转成一个数字:
print("2" + 6)
print("2" + "6")
print("2 + 6")
print("-2e2" * "6")
-- print("error" + 1)

-- 以上代码中"error" + 1执行报错了，字符串连接使用的是 .. ，如：
print(157 .. 428)
print("a" .. "b")

-- 使用 # 来计算字符串的长度，放在字符串前面，如下实例：
local len = "www.runoob.com"
print(#len)

print(#"www.runoob.com")

-- 5.table（表）
print(">>>>>>>>>>>>>>>> 5.table <<<<<<<<<<<<<<<\n")
-- 在 Lua 里，table 的创建是通过"构造表达式"来完成，最简单构造表达式是{}，用来创建一个空表。也可以在表里添加一些数据，直接初始化表:
-- 创建一个空的 table
local tbl1 = {}

-- 直接初始表
local tbl2 = {"apple", "pear", "orange", "grape"}
-- Lua 中的表（table）其实是一个"关联数组"（associative arrays），数组的索引可以是数字或者是字符串。
print("---------table test1---------\n")
a = {}
a["key"] = "value"
key = 10
a[key] = 22
a[key] = a[key] + 11
for k, v in pairs(a) do
    print(k .. " : " .. v)
end
-- 不同于其他语言的数组把 0 作为数组的初始索引，在 Lua 里表的默认初始索引一般以 1 开始。
print("---------table test2---------\n")
local tbl = {"apple", "pear", "orange", "grape"}
for key, val in pairs(tbl) do
    print("Key", key, "val", val)
end
-- table 不会固定长度大小，有新数据添加时 table 长度会自动增长，没初始的 table 都是 nil。
print("---------table test3---------\n")
a3 = {}
for i = 1, 10 do
    a3[i] = i
end
a3["key"] = "val"
print(a3["key"])
print(a3["none"])

-- 6.function（函数）
-- 在 Lua 中，函数是被看作是"第一类值（First-Class Value）"，函数可以存在变量里:
print(">>>>>>>>>>>>>>>> 6.function <<<<<<<<<<<<<<<\n")
print("---------test 1---------\n")
function factorial1(n)
    if n == 0 then
        return 1
    else
        return n * factorial1(n - 1)
    end
end
print(factorial1(5))
factorial2 = factorial1
print(factorial2(5))

-- function 可以以匿名函数（anonymous function）的方式通过参数传递:
print("---------test 2---------\n")
function testFun(tab, fun)
    for k, v in pairs(tab) do
        print(fun(k, v))
    end
end

tab = {key1 = "val1", key2 = "val2"}
testFun(
    tab,
    function(key, val) --匿名函数
        return key .. "=" .. val
    end
)

-- 7.默认降序
print(">>>>>>>>>>>>>>>> 7.table.sort( tablename, sortfunction ) <<<<<<<<<<<<<<<\n")

testTab = {
{id=1,name="z",power=100,lv=22,timev=10},
{id=2,name="d",power=90,lv=23,timev=8},
{id=3,name="a",power=100,lv=21,timev=12},
{id=4,name="b",power=110,lv=21,timev=16},
{id=5,name="c",power=110,lv=21,timev=15}
}

print("DESC= ",string.lower("DESC"),type("desc"),"\n")

testTab = {4,52,1,86,6,5}
table.sort(testTab)

table.insert( testTab, 5, 0 )
for k,v in pairs(testTab) do

	--print("testTab k=",k,"v.id=",v.id)
	print("testTab k=",k,"v=",v)

end
