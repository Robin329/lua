#!/usr/bin/lua

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

-- 对于全局变量和 table，nil 还有一个"删除"作用，给全局变量或者 table 表里的变量赋一个 nil 值，
-- 等同于把它们删掉，执行下面代码就知：
print("---------case 1----------")
local tab1 = {key1 = "val1", key2 = "val2", "val3"}
for k, v in pairs(tab1) do print(k .. " - " .. v) end

tab1.key1 = nil
for k, v in pairs(tab1) do print(k .. " - " .. v) end

print("---------case 2----------")
local tab2 = {k1 = "val1", k2 = "val2", k3 = "val3"}
for k, v in pairs(tab2) do print(k .. " - " .. v) end

tab2.k1 = nil
for k, v in pairs(tab2) do print(k .. " - " .. v) end


-- pairs 和 ipairs区别:
-- pairs: 迭代 table，可以遍历表中所有的 key 可以返回 nil
-- ipairs: 迭代数组，不能返回 nil,如果遇到 nil 则退出
print("---------pairs/ipairs----------\n")

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

for k, v in pairs(tabFiles) do  --输出2 test2, 6 test3, 4 test1
    print(k, v)
end

print("---------case 4----------\n")
local tabFiles = {"alpha", "beta", [3] = "no", ["two"] = "yes"}
for i,v in ipairs(tabFiles ) do    --输出前三个   备注：因为第四个key不是整数
    print( i, tabFiles [i] )
end
print("---------case 5----------\n")
for i,v in pairs(tabFiles ) do    --全部输出
    print( i, tabFiles [i] )
end

print("---------case 6 start----------\n")
local tab = {[1] = "a", [2] = "b","c", [4] = "d"}
print("==== pairs ====\n")
for i, v in pairs(tab) do -- 输出 "a" ,"b", "c"  ,
    print(i .. "-" .. tab[i])
end

print("==== ipairs ====\n")
for i, v in ipairs(tab) do -- 输出 "a" ,k=2时断开
    print(i .. "-" .. tab[i])
end
print("---------case 6 end----------\n")