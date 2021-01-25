#!/usr/local/bin/lua
--第九章 协同程序

--创建协同程序

co = coroutine.create(
	function () print('coroutine create') end

); --挂起状态

--查看状态

print("查看状态=",coroutine.status(co)); --到这里系挂起状态


--从挂起变为运行
coroutine.resume(co); --变为运行


print("查看状态++++=",coroutine.status(co)); --变为停止

corou1=coroutine.create(
	function ()
		i=0
		i=i+1;
		coroutine.yield(); --可以把运行中噶协同程序挂起
	end);


--打印一个数组元素的所有排列
function peremgen(a,n)
	if n == 0 then
		printResult(a);
	else

		for i=1,n do
			a[n],a[i] = a[i],a[n]; --交换值
			peremgen(a,n-1);
			a[n],a[i] = a[i],a[n]; --交换值
		end
	end

end;

function printResult (a)
	for i,v in ipairs(a) do
		io.write(v, " ")
	end
	io.write("\n")
end

--peremgen ({1,2,3,4}, 4);

--使用协同实现实现一个迭代器 从而实现上面功能
function peremgen_cor(a,n)
	if n == 0 then
		coroutine.yield(a);
	else
		for i=1,n do
		a[n],a[i] = a[i],a[n]; --交换值
		peremgen(a,n-1);
		a[n],a[i] = a[i],a[n]; --交换值
		end
	end
end

--定义迭代工厂
function perm(a)
	local n = table.getn(a);
	local co = coroutine.create(
		function ()
			peremgen_cor(a,n);
		end
	)

	return function ()
		local code,res =coroutine.resume(co);
		return res;
		end;
end

--通过for循环打印数组元素排列
for p in perm{"a","b","c"} do
	printResult(p);
end

