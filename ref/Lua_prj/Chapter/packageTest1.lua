#!/usr/local/bin/lua
local P = {};



if _REQUIREDNAME == nil then
	packageTest1= P
else
	_G[_REQUIREDNAME] = P
end


local _G=_G; --�ı价��֮ǰ�����ϻ���

setfenv(1,P); --ʹ��һ��package��ռһ������ ,ʹ�����ַ�����������˽�к���,�����ϻ����ı������ܱ�ֱ�ӷ���

--���ü�ǰ׺Ҳ�Զ�����packageTest1������ĺ���
function sayHello()
	_G.print("Say hello packageTest1");
end


function sayNow()
	_G.print(" packageTest1 now I say : ")
	sayHello();--����Ҫ��ǰ׺���ʰ��ں���
	_G.io.write("io.w");
end

return p;
