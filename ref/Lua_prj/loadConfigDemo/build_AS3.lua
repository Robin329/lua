
require "config"


function strToArr(s,split)
	arr = {};
	i = 0
	start = 1;
	endindex = 1
	while true do
		j,i = string.find(s,split,i+1);
		if i == nil then
			break
		else
			if i>1 then
				endindex = i-1
				local str1 = string.sub(s,start,endindex)
				if str1~=nil or str1 ~= "" then
					table.insert(arr,str1);
				end				
				start=endindex+2
			end
		end
	end
	local str2 = string.sub(s,start,string.len(s))
	if str2~=nil or str2 ~= "" then
		table.insert(arr,str2);
	end	
	return arr
end

costMsStart = os.clock()

local file1=io.input(config.url)  --

local str=io.read("*a")

--ȥ���������԰����﷨
str,count = string.gsub(str, "Lang[%.%a%w+]+", '\'Language_cn\'');

assert(loadstring(str))()

tableName = "" --
newLine = "\r"

buildLog = ""; --��־�ļ�������

if config.tableName ~= "" then
    tableName = config.tableName
else
	local urlArr = strToArr(config.url,'/')	
	local len1 = table.getn(urlArr)	
	local fileNameArr = strToArr(urlArr[len1],'%.')	
	tableName = fileNameArr[1]	
end

print("tableName=" .. tableName)

buildLog = buildLog.."tableName=" .. tableName..newLine

cfg_table = _G[tableName];

if not cfg_table then
    print("--��ʼ�������ñ�---")
	buildLog = buildLog.."--��ʼ�������ñ�---"..newLine
    for k,v in pairs(_G) do	    
    	if string.lower(k) == string.lower(tableName) then --�Ա��������Ǻ��Դ�Сд��   		
    		cfg_table = v
    		break;
    	end
    end
end

if not cfg_table then
    print("û���ҵ�����Ϊ:" .. tableName .. "������")
	buildLog = buildLog.."û���ҵ�����Ϊ:" .. tableName .. "������"..newLine
    return
else
    print("�Ѿ��ҵ����ñ�:"..tableName..",���ڿ�ʼ����AS3��\n")
	buildLog = buildLog.."�Ѿ��ҵ����ñ�:"..tableName..",���ڿ�ʼ����AS3��"..newLine
end


function  getFileData(url)
   
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



function getSubFixName(layer,fixName)	
    subname = ""
	if fixName == nil then
		fixName = "_sub"
	end
	
    for i=1,layer,1 do
    	subname = subname .. fixName
    end    
    return subname
end
--�����ֶ�
function isFilter(key,layer)
	if layer<0 then
		layer = 0
	end
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
--���������ڵĽṹ��(û�õ�)
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

--��ȡ��,(û�õ�)
function getSubClassLayer(key,targetTab)
    local layer=1	
    while not targetTab[key] do
    	layer = layer + 1
		local flag = false
    	for k,v in pairs(targetTab) do			
			if type(v) == "table" then				
				if isClassForAS3(v) then					
					targetTab = v
					flag = true
					break
				elseif isAsArray(v) then					
					local tmpV = v[1]
					while type(tmpV)=="table" and isAsArray(tmpV) do
						layer = layer+1
						tmpV = tmpV[1]											
					end
					layer = layer+1
					if type(tmpV)=="table" and isClassForAS3(tmpV) then
						targetTab = tmpV
						flag = true						
						break
					end					
				end		
			end			
    	end
		
		if not flag then			
			break
		end
			
    end
    
    return layer
end

function isEmptyTab(tab)
	for k,v in pairs(tab) do
		return false
	end
	return true;
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

function writeFile(url,data)
	--os.remove(url)
	file = io.open(url, "w");
	assert(file);
	file:write(data);
	file:close();
end

GCReaderInfo = {};

classNum = 0;

function build_as3(csName,luaTab,isDp,depth,parent)	
				
    local preFix="		";
    local varstr=preFix;
    local luaType
    local as3Type
    local k;
    local layer;
    local pkey=""; --���ڵ���
	
	if parent ~= "" then
		parent = parent.."."
	end	
	
    for k,v in pairs(luaTab) do    	
    	luaType = type(v)
    	as3Type = config.dataType[luaType];    	
    	if luaType=="table" then			
    	    local subClass,subKey						
    	    local isArr = isAsArray(v)	
    	    if isArr then
    	    	--as3����				
    	    	layer = 1				
				pkey = k;				
				pkey = parent..pkey
				table.insert(GCReaderInfo,{key=pkey,cs="Array"})
				local index = 1
				local tmpV = v[index]				
    	    	while type(tmpV)=="table" and isAsArray(tmpV) do
    	    		layer = layer+1
    	    		tmpV = tmpV[1]					
					pkey = pkey..".n"
					table.insert(GCReaderInfo,{key=pkey,cs="Array"})					
    	    	end					
    	    	layer = layer+1								
    	    	if type(tmpV)=="table" and isClassForAS3(tmpV) then					
    	    		subClass = tmpV;					
    	    		subKey = k;									
    	    	end				
				
    	    else
    	    	--as3��				
    	    	subClass = v				
    	    	layer = 1; 					
    	    	subKey = k;    	    					
    	    end		
    	    if subClass and isClassForAS3(subClass) then
    	    	local subname = "_"..(layer+depth).."sub";				
				local pNodeStr="",n
				if parent~= "" then
					pNodeStr,n=string.gsub(parent,"(%.n+)","$")				
					pNodeStr,n=string.gsub(pNodeStr,"(%.+)","$")				
					pNodeStr,n=string.gsub(pNodeStr,"(%$+)","_")
					pNodeStr = pNodeStr.."p_"
				end				
    	    	subname = pNodeStr..subKey .. subname
    	    	if not isArr then
    	    		as3Type = config.dataType["sub"]
    	    		if as3Type == "" then
    	    			as3Type = subname;				
    	    		end
    	    	end
    	    	pkey = parent..subKey.. getSubFixName((layer-1),".n")
				table.insert(GCReaderInfo,{key=pkey,cs=subname})				
    	    	build_as3(subname,subClass,false,layer,pkey)
    	    end    	    
    	    varstr = getTabVars(varstr,k,as3Type,luaType,depth-1) --�ú��������˹��˵��ֶ�			
    	else			
    	    varstr = getTabVars(varstr,k,as3Type,luaType,depth-1)			
    	end
    	
    end	-- end of for 	
    
	data =  getFileData("templete.as") --
	data,count = string.gsub(data,"%$pkg%$",config.as3Pkg);		
	data,count = string.gsub(data,"%$cs%$",csName);		
	data,count = string.gsub(data, "%$var%$",varstr);
	csurl = config["as3Save"] .. csName .. ".as";
	writeFile(csurl,data) 	
	classNum = classNum+1	
	local log1
	local log2
	local log3	
	if isDp then
		log1 = "----��ʼ����Dp��----"
		log2 = "���ɵ�Dp���Ѿ�������:"..csurl
		log3 = "----Dp���������---"				
	else
		log1 = "----��ʼ��������----"
		log2 = "���ɵ������Ѿ�������:"..csurl
		log3 = "----�����������---"		
		local isEmpty = ""
		if isEmptyTab(luaTab) then
			isEmpty = ",���Ǹ�������ֶ��ǿյ�,���ֶ�������ñ�";
		end
		log2 = log2..isEmpty			
	end
	print(log1)
	print(log2) 
	print(log3.."\n")
	local newLine = "\r"
	buildLog = buildLog..log1..newLine..log2..newLine..log3..newLine.."***************************** �����ָ��� ******************************"..newLine
    return varstr;
end
if config.as3Name=="" then
	tableClass = tableName.."Dp"
else
	tableClass = config.as3Name
end
build_as3(tableClass,cfg_table,true,0,"",0)
local log1 = "--- ��ʼ����read������ ----";
local log2 =""
local log3 = ""

print("\n"..log1)
function onSortGCRead(a,b)
	return a.key < b.key
end
table.sort(GCReaderInfo,onSortGCRead)

local n = table.getn(GCReaderInfo)
print("----------------����"..n.."��GCR------------")
fixStr = "		"

GCReaderStr = fixStr.."reader.addTypes("..newLine
GCReaderStr = GCReaderStr..fixStr..'""'..","..tableClass..","..newLine
for k,v in pairs(GCReaderInfo) do
	GCReaderStr = GCReaderStr..fixStr..'"'..v.key..'"'..","..v.cs..","..newLine
end
GCReaderStr,_ = string.gsub(GCReaderStr,newLine.."$","");
GCReaderStr,_ = string.gsub(GCReaderStr,",$","");
GCReaderStr = GCReaderStr..newLine
GCReaderStr = GCReaderStr..fixStr..");"
fName = config.as3Save..config.GCRName..".as"
local GCReaderData =  getFileData("GCReaderTemplete.as") --
GCReaderData,count = string.gsub(GCReaderData,"%$GCReaderBody%$",GCReaderStr);		
GCReaderData,count = string.gsub(GCReaderData,"%$readName%$",config.readName);		
writeFile(fName,GCReaderData)

log2 = "�Ѿ�����read����������:"..fName
print(log2);
log3 = "--- ����read���������----"
print(log3.."\n")

buildLog = buildLog..log1..newLine..log2..newLine..log3..newLine.."***************************** �����ָ��� ******************************"..newLine

costMsEnd = os.clock()
costMs = (costMsEnd-costMsStart)*1000
log1 = "----���������Ѿ�����"..classNum.."����Ҫ��AS3�� ����ʱ:" .. costMs.."���� ----"
buildLog = buildLog..log1..newLine..newLine
logFileName = "bLog_"..os.date("%Y��%m��%d�� %Hʱ%M��%S��").."_.txt"
writeFile(config.logSave..logFileName,buildLog)
print(log1)





