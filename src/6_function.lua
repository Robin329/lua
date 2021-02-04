#!/usr/bin/lua
#!/usr/local/bin/lua
-- 1. 函数定义
-- Lua 编程语言函数定义格式如下：

-- optional_function_scope function function_name( argument1, argument2, argument3..., argumentn)
--     function_body
--     return result_params_comma_separated
-- end
-- 解析：

-- optional_function_scope: 该参数是可选的制定函数是全局函数还是局部函数，未设置该参数默认为全局函数，如果你需要设置函数为局部函数需要使用关键字 local。

-- function_name: 指定函数名称。

-- argument1, argument2, argument3..., argumentn: 函数参数，多个参数以逗号隔开，函数也可以不带参数。

-- function_body: 函数体，函数中需要执行的代码语句块。

-- result_params_comma_separated: 函数返回值，Lua语言函数可以返回多个值，每个值以逗号隔开。


--[[ 函数返回两个值的最大值 --]]
print(">>>>>>>>>>>>>>>> 1. 函数 <<<<<<<<<<<<<<<\n")
function max(num1, num2)

    if (num1 > num2) then
       result = num1;
    else
       result = num2;
    end

    return result;
 end
 -- 调用函数
 print("两值比较最大值为 ",max(10,4))
 print("两值比较最大值为 ",max(5,6))

-- 2. 多返回值
s, e = string.find("www.runoob.com", "runoob")
print("1.1 ==>")
print(s, e)

-- 2. 多返回值
print(">>>>>>>>>>>>>>>> 2. 多返回值 <<<<<<<<<<<<<<<\n")
print("2.1 ==>")
function maximum (a)
    local mi = 1             -- 最大值索引
    local m = a[mi]          -- 最大值
    for i,val in ipairs(a) do
       if val > m then
           mi = i
           m = val
       end
    end
    return m, mi
end

print(maximum({8,10,23,12,5}))


-- 3. 可变参数
print(">>>>>>>>>>>>>>>> 3. 可变参数 <<<<<<<<<<<<<<<\n")
print("3.1 ==>")
function add(...)
    local s = 0
      for i, v in ipairs{...} do   --> {...} 表示一个由所有变长参数构成的数组
        s = s + v
      end
      return s
    end
print(add(3,4,5,6,7))  --->25

print("3.2 ==>")
function average1(...)
    local result = 0
    local arg={...}    --> arg 为一个表，局部变量
    for i,v in ipairs(arg) do
        result = result + v
    end
    print("总共传入 " .. #arg .. " 个数")
    return result/#arg
end

print("平均值为",average1(10,5,3,4,5,6))

print("3.3 ==>")
function average2(...)
    local result = 0
    local arg={...}
    for i,v in ipairs(arg) do
       result = result + v
    end
    print("总共传入 " .. select("#",...) .. " 个数")
    return result/select("#",...)
 end

 print("平均值为",average2(10,5,3,4,5,6))


--  通常在遍历变长参数的时候只需要使用 {…}，
-- 然而变长参数可能会包含一些 nil，那么就可以用 select 函数来访问变长参数了：
-- select('#', …) 或者 select(n, …)

-- select('#', …) 返回可变参数的长度
-- select(n, …) 用于返回 n 到 select('#',…) 的参数
-- 调用 select 时，必须传入一个固定实参 selector(选择开关) 和一系列变长参数。
-- 如果 selector 为数字 n，那么 select 返回 n 后所有的参数，否则只能为字符串 #，这样 select 返回变长参数的总数。
print("3.4 ==>")
do
    function foo(...)
        for i = 1, select('#', ...) do  -->获取参数总数
            local arg = select(i, ...); -->读取参数
            print("arg", arg);
        end
    end

    foo("1", 2, 3, 4);
end