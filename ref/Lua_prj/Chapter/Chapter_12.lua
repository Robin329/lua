#!/usr/local/bin/lua
--12章  数据文件与持久化

function basicSerialize(o)

	if type(o) == "number" then
		return tostring(o);
	else
		return string.format("%q",o)
	end
end;


function save(name,value,saved)
	saved=saved or {};
	io.write(name," = ");
	if type(value) == "number" or type(value) == "string" then
		io.write(basicSerialize(value),"\n")
	elseif type(value) == "table" then
		if saved[value] then
			io.write(saved[value],"\n")
		else
			saved[value] = name;
			io.write("{}\n");
			for k,v in pairs(value) do
				local fieldname= string.format("%s[%s]",name,basicSerialize(k));
				save(fieldname,v,saved);
			end

		end
	else
		error("cannot save a " .. type(value));
	end

end

a = {x=1, y=2; {3,4,5}}
a[2] = a -- cycle
a.z = a[1] -- shared sub-table

save('a', a)







