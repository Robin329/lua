
require "config"

local file1=io.input(config.url)  --

local str=io.read("*a")

--print(str)

--去掉导入语言包的语法
str,count = string.gsub(str, "Lang[%.%a%w+]+", '\'Language_cn\'');

--print(str)

loadstring(str)()

tableName = "" --

if config.tableName ~= "" then
	tableName = config.tableName
else 

end

print("tableName=" .. tableName)

cfg_table = _G[tableName];

if not cfg_table then
	print("--开始搜索配置表---")
	for k,v in pairs(_G) do	

		if string.lower(k) == string.lower(tableName) then
			print("k="..k..",tableName="..tableName)
			cfg_table = v
			break;
		end
	end
end

if not cfg_table then
	print("没有找到表名为:" .. tableName .. "的配置")
	return
else
	print("已经找到配置表:"..tableName..",正在开始生产AS3\n")
end


function getASClass(url)
	url = "templete.as"
	local file = io.open(url, "r");
	assert(file);
	local data = file:read("*a"); -- 
	file:close();
	return data;

end


--暂时没有用
function tableToClass(csName,cfg_table)
	data = getASClass()
	data,count = string.gsub(data,"%$cs%$",csName);
	--print(count)
	varstr=getTabVars(cfg_table);	
	data,count = string.gsub(data, "%$var%$",varstr);
	csurl = csName .. ".as";
	os.remove(csurl)
	file = io.open(csurl, "w");
	assert(file);
	file:write(data);
	file:close();
	print("???-??3?AS3??@jd???:"..csurl)
end

--table是AS3数组
function isAsArray(tab)	

	local n = table.getn(tab);	
	if n > 0 then		
		for k,v in pairs(tab) do
			if type(k) == "string" then
				return false			
			end			
		end
		return true
	end
	return false
end

--table是AS3类 
function isClassForAS3(tab)
		
	local flag = true
	for k,v in pairs(tab) do
		if type(k) ~= "string" then
			flag = false
			break
		end
	end
	return flag
end



function getSubFixName(layer)	
	subname = ""	
	for i=1,layer,1 do
		subname = subname .. "_sub"
	end
	
	return subname
end

function isFilter(key,layer)
	local flag = false
	local str
	for k,v in pairs(config.filters) do
		str,count = string.gsub(v, "%*%.", '');		
		if str==key and layer==count then
			flag = true
			break
		end
	end
	
	return flag;	
end
--
function getTabVars(varstr,k,as3Type,luaType,layer)
	if not isFilter(k,layer) then
		if as3Type then
			varstr = varstr .."public var ".. k ..':'..as3Type .. ';\r'.."		"
		else
			varstr = varstr .."public var ".. k ..':'..luaType .. ';\r'.."		"
		end	
	end
	
	return varstr;
end
--遍历数组内的结构体
function getSubArrayLayer(tagetTab)
	
	--基于配置数组内的元素数据类型一直:
	--1).table嵌套table {{},{},{}},
	--2).多种数据类型组合的table:{1,2,3},{"a","b",1}
	local luaType
	local as3Type
	for k,v in pairs(tagetTab) do		
		luaType = type(v)
		as3Type = config.dataType[luaType];		
		if luaType=="table" then
			layer = layer+1
			local subClass,subKey		
			if isAsArray(v) then
				--as3数组				
				layer = layer+1				
				local tmpV = v[1]
				while isAsArray(tmpV) do
					layer = layer+1
					tmpV = tmpV[1]
				end
				layer = layer+1		
				if isClassForAS3(tmpV) then
					subClass = tmpV;					
					subKey = k;
				end
			end
		end
	end
	
	return layer
end

--获取层
function getSubClassLayer(key,targetTab)
	local layer=1		
	while not targetTab[key] do
		layer = layer + 1
		for k,v in pairs(targetTab) do
			if type(v) == "table" and isClassForAS3(v) then				
				targetTab = v
				break
			end
		end		
	end
	
	return layer
end
--日志
function logData(fName,data)
	file = io.open(config['logSave'] .. fName, "w");
	assert(file);
	file:write(data);
	file:close();
end

function logTable(tab,logFileName)
	local subLog = "";
	local fixname = "subLog-"
	if logFileName~="" and logFileName ~=nil then
		fixname = logFileName
	end
	
	for kk,vv in pairs(tab) do
		subLog = subLog.."key="..kk..",v="..type(vv).."\r\n"
		fixname = fixname.."-"..kk.."-"
	end
	logData(fixname.."_log.txt",subLog)
end

function build_as3(csName,luaTab,isDp,depth)	
				
	local varstr="		";
	local luaType
	local as3Type
	local k;
	local layer;
	
	for k,v in pairs(luaTab) do
		
		luaType = type(v)
		as3Type = config.dataType[luaType];
		
		if luaType=="table" then			
			local subClass,subKey						
			local isArr = isAsArray(v)	
			if isArr then
				--as3数组				
				layer = 1			
				local tmpV = v[1]
				while type(tmpV)=="table" and isAsArray(tmpV) do
					layer = layer+1
					tmpV = tmpV[1]
				end								
				layer = layer+1		
				if type(tmpV)=="table" and isClassForAS3(tmpV) then					
					subClass = tmpV;					
					subKey = k;
				end
				
			else
				--as3类					
				subClass = v
				layer = getSubClassLayer(k,cfg_table);							
				subKey = k;
				
			end		
			if subClass and isClassForAS3(subClass) then
				local subname = getSubFixName(layer)				
				subname = subKey .. subname
				if not isArr then
					as3Type = config.dataType["sub"]
					if as3Type == "" then
						as3Type = subname;				
					end
				end
												
				build_as3(subname,subClass,false,layer)
			end
			
			varstr = getTabVars(varstr,k,as3Type,luaType,depth)
		
		else			
			varstr = getTabVars(varstr,k,as3Type,luaType,depth)			
		end
		
		
	end	-- end of for 
	
	data = getASClass() --
	data,count = string.gsub(data,"%$cs%$",csName);		
	data,count = string.gsub(data, "%$var%$",varstr);
	csurl = config["as3Save"] .. csName .. ".as";
	os.remove(csurl)
	file = io.open(csurl, "w");
	assert(file);
	file:write(data);
	file:close();
	
	if isDp then	
		print("----开始生成Dp类----")
		print("生成的Dp类已经保存在:"..csurl) --
		print("----Dp类生成完成---\n")
		
	else
		print("----开始生成子类----")
		print("生成的类类已经保存在"..csurl) --	
		print("----子类生成完成----\n")		
	end
	
	return varstr;
end

build_as3(tableName.."Dp",cfg_table,true,0)

print("----所有配置已经生产需要的AS3 ----")

