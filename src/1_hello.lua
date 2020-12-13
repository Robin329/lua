#!/usr/bin/lua
-- 这是单行注释
--[[
    这是多行注释
    这是多行注释
--]]

-- 1. 打印 hello, world
print("Hello, world\n")

print("Hello, " .. "World\n")

-- 2. 变量类型
-- 2.1 全局变量
print(b)
print()
b = 10
print("b = " .. b)

-- 删除全局变量
b = nil
print(b)
