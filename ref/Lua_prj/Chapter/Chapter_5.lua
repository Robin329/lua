--第五章 函数

--lua函数可以返回多个值
function makeVal()

	return 10,20;
end;

a,b=makeVal();

print(a,b);

print((makeVal())); -- (makeVal()) 强制返回一个值


--可变参数
print("----可变参数------");

function trace(...)

	for i,v in ipairs(arg) do
		print(i,"\t");
	end;
	print(arg.n); --参数个数
end;

trace(1,"abc");

--通过table的name字段排序
network = {
{name = "grauna", IP = "210.26.30.34"},
{name = "arraial", IP = "210.26.30.23"},
{name = "lua", IP = "210.26.23.12"},
{name = "derain", IP = "210.26.23.20"},
};
table.sort(network,function (val1,val2)
			return (val1.name > val2.name)
			end);


--闭包
function newCounter()
	i=0;
	return function ()
			i=i+1;
			return i
			end;
end;

c1=newCounter();

print("----闭包----");

print(c1());
print(c1());

local M = {}

function M:test(a,b)
	print("arg.n=",arg[1])
end


M:test(10,20)












