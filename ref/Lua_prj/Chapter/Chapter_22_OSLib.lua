#!/usr/local/bin/lua
-- 22章

require "CommonFunc"

local glb = Global;

now = os.time();

print(now);

t= os.date("*t",now);

--print("t== ",t,type(t))
Global.PrintTabKV(t)

ts= os.date("");

print(ts,type(ts))

print(os.clock()) --返回代码执行到该处 花费的时间

a = 10
if a>=10 then
print("aaaaaaaaaa")
end

