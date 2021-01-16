#!/usr/bin/lua
--[[
循环类型	        描述
while 循环	       在条件为 true 时，让程序重复地执行某些语句。执行语句前会先检查条件是否为 true。
for 循环	       重复执行指定语句，重复次数可在 for 语句中控制。
repeat...until	  重复执行循环，直到 指定的条件为真时为止
循环嵌套	       可以在循环内嵌套一个或多个循环语句（while do ... end;for ... do ... end;repeat ... until;）
]]

-- 1. while
print(">>>>>>>>>>>>>>>> 1. while type <<<<<<<<<<<<<<<\n")
local a=10
while( a < 20 )
do
   print("a 的值为:", a)
   a = a+1
end

print(">>>>>>>>>>>>>>>> 2. for type <<<<<<<<<<<<<<<\n")

--[[
数值for循环
Lua 编程语言中数值 for 循环语法格式:

for var=exp1,exp2,exp3 do
    <执行体>
end
]]
print("2.1 ==>")
function f(x)
    print("function")
    return x*2
end
for i=1,f(5) do
    print(i)
end

for i=10,1,-1 do
    print(i)
end

-- 泛型for循环
-- 泛型 for 循环通过一个迭代器函数来遍历所有值，类似 java 中的 foreach 语句。

-- Lua 编程语言中泛型 for 循环语法格式:

--打印数组a的所有值
a = {"one", "two", "three"}
for i, v in ipairs(a) do
    print(i, v)
end
-- i是数组索引值，v是对应索引的数组元素值。ipairs是Lua提供的一个迭代器函数，用来迭代数组。


-- 3. repeat loop
-- Lua 编程语言中 repeat...until 循环语法格式:

-- repeat
--    statements
-- until( condition )
print(">>>>>>>>>>>>>>>> 3. repeat loop <<<<<<<<<<<<<<<\n")
--[ 变量定义 --]
a = 10
--[ 执行循环 --]
repeat
   print("a的值为:", a)
   a = a + 1
until( a > 15 )


-- 4. 循环嵌套
print(">>>>>>>>>>>>>>>> 4. 循环嵌套 <<<<<<<<<<<<<<<\n")
-- 语法
-- Lua 编程语言中 for 循环嵌套语法格式:

-- for init,max/min value, increment
-- do
--    for init,max/min value, increment
--    do
--       statements
--    end
--    statements
-- end

-- Lua 编程语言中 while 循环嵌套语法格式:

-- while(condition)
-- do
--    while(condition)
--    do
--       statements
--    end
--    statements
-- end
-- Lua 编程语言中 repeat...until 循环嵌套语法格式:

-- repeat
--    statements
--    repeat
--       statements
--    until( condition )
-- until( condition )
-- 除了以上同类型循环嵌套外，我们还可以使用不同的循环类型来嵌套，如 for 循环体中嵌套 while 循环。
local j =2
for i=2,10 do
   for j=2,(i/j),2 do
        print(i/j)
        print("i = " .. i .. " j = " .. j)
        print(i%j)
      if(not(i%j)) then
         break
      end
      if(j > (i/j)) then
         print("i 的值为：",i)
      end
   end
end