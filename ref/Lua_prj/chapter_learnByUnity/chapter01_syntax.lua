-- 基础语法
--[[
多行注释
--]]

--type 函数检查数据类型

student = {}

strType = type(student)
a = "hello"
print("strType=",strType,type(a))
a = "world"
print("a",a)

longStr = [[
    这是一串很长的字符串
]]

--用 ..链接字符串 数字后面必须加上空格才能用..
print("longStr",longStr,11 .. 12) 


--转换成数字
tonumber("1999")

--三目在lua中的实现
-- a?b:c
a = false
b = false
c = 100
flag = (a and b) or c; --通过逻辑运算符实现
print("flag",flag)

--强大的table
arr = {"a","b","c"} --创建一个数组
mapDict = {age=10,sex="man"}; --创建一个字典
mixArrMap = {"a","c",name="lily",city="guangzhou"}; --数字和字典混合
print("arr[1]",arr[1],"数组长度",table.getn(arr))
print("mapDict.age",mapDict.age)
print("mixArrMap",mixArrMap[1],mixArrMap.city)
--获取table长度的技巧
length = #arr
print("length",length)

--table的域可以用分号代替
arr = {"a","b";"c",x=0;y=1}

--交换变量 技巧和python一样
x,y=10,200
x,y = y,x;
print("交换xy后",x,y)

--条件控制;lua中只有false和nil是假 其他都是真
flag = true
if flag then
    -- body
else
    -- body
end

flag1 = false
flag2 = true

if flag1 then
    -- body
elseif flag2 then
    -- body
    print("elseif log 哈哈哈")
end

if flag then

end

--循环语句,lua没有continue

count = 0
while count<4 do
    print("while循环 count",count)
    count = count + 1;
end


count = 0
repeat
    print(" repeat until 循环 count",count)
    count = count+1
until count>4 --类似js的do while

for i=1,10,2 do
    print("for循环step是2",i)
end

--pairs列表和map都能遍历

for key, value in pairs(mixArrMap) do
    print("xxx pairs key,value",key,value)
end

--ipairs只能遍历列表不能遍历map

for key, value in ipairs(arr) do
    print("yyy ipairs key,value",key,value)
    
end

--第五章函数

function sayHello()
    print("hello")
    return "a","b","c","d"
end

val = sayHello()
print(sayHello())
print(type(val),"val",val)

--函数可变参数
function testArg(a,b,...)
    print("函数可变参数的个数",arg.n,"arg",arg) --函数可变参数的个数
end

testArg(1,2,3,4);

--函数命名参数 其实就是传table

function nameArg(params)
    print("函数命名参数 params",params.age,params.name)
end

nameArg{age=1,name="lily"} --函数参数是table的 可以不用括号就能调用函数

--声明递归局部函数的方式
local fact = function (n)
    if n==0 then
        return 1
    else
        return fact(n-1)
    end
    
end
--上面这种方式导致Lua编译时遇到fact(n-1)并不知道他是局部函数fact，Lua会去查找是否有这样的全局函数fact,找不到全局fact所以编译会报错

--fact(10)

local fact1
fact1 = function (n)
    if n==0 then
        return 1
    else
        return fact1(n-1)
    end
    
end
fact1(10)


EDist = {Near="Near",Middle="Middle",Far="Far"}
position = {}
position[EDist.Near] = {x=1,y=2,z=3};
position[EDist.Middle] = {4,5,6};
position[EDist.Far] = {7,8,9};

local infos = {}
infos[1]="a";
infos[2]="b";
infos[4]="c";

for i,v in ipairs(infos) do
    print("infos",i,v)
end