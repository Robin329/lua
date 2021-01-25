#!/usr/local/bin/lua
--第十一章 数据结构

--创建一个n行m列的矩阵

mt={}

n=4
m=3

--把行列组合起来 生成一个伪二维数组
for i=1,n do
	for j=1,m do
	mt[i*m+j]='0-'..i..'-'..j
	end
end

for i in pairs(mt) do
	print('mt--: ',i,mt[i]);

end

print("--------");

--链表

list={next={next={},value=2},value=1};


while list do
	print("list.value=",list.value);
	list=list.next
end

t1={"where","are","you",120,n={1,2}};

s1=table.concat(t1); --把table中的所有字符串连接成一个字符
print("s1",s1);

s2=table.concat(t1,"-");--把table中的所有字符串连接成一个字符  并且每个字符串之间用"-"隔开
print(s2);




