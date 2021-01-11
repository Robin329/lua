--第十章 两个实例

-- 1.LUA作为数据描述语言的使用

--格式化文本输出函数
function fwrite(fmt,...)
	return io.write(string.format(fmt,unpack(arg)));
end;

--写html页面的头部
function BEGIN()
	io.write(
		[[
			<HTML>
			<HEAD><TITLE>Projects using Lua</TITLE></HEAD>
			<BODY BGCOLOR="#FFFFFF">
			Here are brief descriptions of some projects around the
			world that use <A HREF="home.html">Lua</A>.

		]]

	)
end;

function entry0(o)
	N=N+1
	local title = o.title or '(no title)'
	fwrite('<LI><A HREF=""#%D>%s</A>\n',N,title);
end;

function entry1(o)
	N=N+1;
	local title = o.title or o.org or 'org';
	fwrite('<HR>\n<H3>\n');
	local href = '';

	if o.url then
		href = string.format(' HREF="%s"',o.url);
	end
	fwrite('<A NAME="%D"%s>%s</A>\n',n,href,title);

	if o.title and o.org then
		fwrite('\n<SMALL><EM>%s</EM></SMALL>', o.org)
	end
	fwrite('\n</H3>\n')

	if o.description then
		fwrite('%s', string.gsub(o.description,'\n\n\n*', '<P>\n'))
		fwrite('<P>\n')
	end

	if o.email then
		fwrite('Contact: <A HREF="mailto:%s">%s</A>\n',
		o.email, o.contact or o.email)
	elseif o.contact then
		fwrite('Contact: %s\n', o.contact)
	end

end

function END()
fwrite('</BODY></HTML>\n')
end

--马尔可夫链算法









