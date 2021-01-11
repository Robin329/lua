
require "config"

local file1=io.input(config.url)  --

local str=io.read("*a")

--print(str)

--ȥ���������԰����﷨
str,count = string.gsub(str, "Lang[%.%a%w+]+", '\'Language_cn\'');

--print(str)

loadstring(str)()

tableName = "" --

if config.tableName ~= "" then
    tableName = config.tableName
end

print("tableName=" .. tableName)

cfg_table = _G[tableName];

if not cfg_table then
    print("--��ʼ�������ñ�---")
    for k,v in pairs(_G) do	
    
    	if string.lower(k) == string.lower(tableName) then
    		print("k="..k..",tableName="..tableName)
    		cfg_table = v
    		break;
    	end
    end
end

if not cfg_table then
    print("û���ҵ�����Ϊ:" .. tableName .. "������")
    return
else
    print("�Ѿ��ҵ����ñ�:"..tableName..",���ڿ�ʼ����AS3��\n")
end


function getASClass(url)
    url = "templete.as"
    local file = io.open(url, "r");
    assert(file);
    local data = file:read("*a"); -- 
    file:close();
    return data;

end

--table��AS3����
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

--table��AS3�� 
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
--���������ڵĽṹ��
function getSubArrayLayer(tagetTab)
	
    --�������������ڵ�Ԫ����������һֱ:
    --1).tableǶ��table {{},{},{}},
    --2).��������������ϵ�table:{1,2,3},{"a","b",1}
    local luaType
    local as3Type
    for k,v in pairs(tagetTab) do		
    	luaType = type(v)
    	as3Type = config.dataType[luaType];		
    	if luaType=="table" then
    	    layer = layer+1
    	    local subClass,subKey		
    	    if isAsArray(v) then
    	    	--as3����				
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

--��ȡ��
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
--��־
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
    	    	--as3����				
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
    	    	--as3��					
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
    	print("----��ʼ����Dp��----")
    	print("���ɵ�Dp���Ѿ�������:"..csurl) --
    	print("----Dp���������---\n")
    	
    else
    	print("----��ʼ��������----")
    	print("���ɵ������Ѿ�������"..csurl) --	
    	print("----�����������----\n")		
    end
    
    return varstr;
end

build_as3(tableName.."Dp",cfg_table,true,0)

print("----���������Ѿ�������Ҫ��AS3 ----")

