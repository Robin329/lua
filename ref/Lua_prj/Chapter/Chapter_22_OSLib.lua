#!/usr/local/bin/lua
-- 22��

require "CommonFunc"

local glb = Global;

now = os.time();

print(now);

t= os.date("*t",now);

--print("t== ",t,type(t))
Global.PrintTabKV(t)

ts= os.date("");

print(ts,type(ts))

print(os.clock()) --���ش���ִ�е��ô� ���ѵ�ʱ��

a = 10
if a>=10 then
print("aaaaaaaaaa")
end

