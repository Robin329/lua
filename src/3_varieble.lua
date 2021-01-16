#!/usr/bin/lua
-- 变量在使用前，需要在代码中进行声明，即创建该变量。
-- 
-- 编译程序执行代码之前编译器需要知道如何给语句变量开辟存储区，用于存储变量的值。
-- 
-- Lua 变量有三种类型：全局变量、局部变量、表中的域。
-- 
-- Lua 中的变量全是全局变量，那怕是语句块或是函数里，除非用 local 显式声明为局部变量。
-- 
-- 局部变量的作用域为从声明位置开始到所在语句块结束。
-- 
-- 变量的默认值均为 nil。

-- 1. Variable type
print(">>>>>>>>>>>>>>>> 1. Variable type <<<<<<<<<<<<<<<\n")
a = 5               -- 全局变量
local b = 5         -- 局部变量

print("1. a = " .. a .. ",b = " .. b)
print("2. a = " .. a .. ",b = " .. b)
function joke()
    c = 5           -- 全局变量
    local d = 6     -- 局部变量
    print("1. c = " .. c .. ",d = " .. d)
end
joke()
local d = 1
local c = 2
joke()
print("2. c = " .. c .. ",d = " .. d)


print(c,d)          --> 5 nil

do
    local a = 6     -- 局部变量
    b = 6           -- 对局部变量重新赋值
    print(a,b);     --> 6 6
end

print(a,b)      --> 5 6

-- 应该尽可能的使用局部变量，有两个好处：
-- 
-- 1. 避免命名冲突。
-- 2. 访问局部变量的速度比全局变量更快。


-- 2. Assignment
print(">>>>>>>>>>>>>>>> 2. Assignment <<<<<<<<<<<<<<<\n")

m, n = 1, 2, 3
print("m" .. m .. "n" .. n)
n, m = m, n
print("m" .. m .. "n" .. n)

h = "hello" .. "world"

print(h)


-- 3. Index
-- 对 table 的索引使用方括号 []。Lua 也提供了 . 操作。
print(">>>>>>>>>>>>>>>> 3. Index <<<<<<<<<<<<<<<\n")

site = {}
site["key"] = "www.baidu.com"

print(site["key"])
print(site.key)

site1 = {}
site1["a"] = "robin"
print(site1["a"])
print(site1.a)

site2 = {"a", "b", "c"}
for k, v in pairs(site2) do
    print("Key", k, "val", v)
end
print(site2[1])



