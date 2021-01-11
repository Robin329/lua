
print("hello")

Global={}

function Global.PrintTabKV(t)
	for i in pairs(t) do
		print("key=",i," val=",t[i])
	end
end

local str = "风雷涌动，<MsgObj>PLAYER,0</MsgObj>将<MsgObj>ITEM,{$1}</MsgObj>成功进阶为<MsgObj>ITEM,{$2}</MsgObj>，神装降世，谁与争锋"


local pos,arr = 0, {}
local delimiter ="<MsgObj>.-</MsgObj>"

print("ddddd = ",string.find(str,delimiter, pos,true))

-- for each divider found
for st,sp in function() return string.find(str,delimiter, pos,true) end do
	print("st sp",st,sp)
	table.insert(arr, string.sub(str, pos, st - 1))
	pos = sp + 1
end



print("---------ffffffff ")



par = "/%*.-%*/" -- /%*.-%*/ 采用 '.-' 则为最短匹配，即匹配 "/*" 开始到第一个 "*/"  之前的部分

par = "<MsgObj>.-</MsgObj>"




print(string.gsub(str,par , "|"))

print(string.gmatch(str,par))





function getParttemContent(str,parttem)

	parttem="<MsgObj>.-</MsgObj>"
	local ret = {}
	for name,value in string.gmatch(str,parttem) do  --string.gmatch函数将返回一个迭代器，用于迭代所有出现在给定字符串中的匹配字符串

		--print("getParttemContent name=",name,"value=",value)

		local target = string.gsub(name,"/", "")
		target = string.gsub(target,"<MsgObj>", "")
		--print("target=",target)
		table.insert(ret,target)
	end
	return ret
end


function transform(str)

	local arr= {}

	local par = "<MsgObj>.-</MsgObj>"
	local pCnt = getParttemContent(str)

	local delimiter = "|"

	local replaceStr=string.gsub(str,par,delimiter)
	print("transform str=",str)
	print("transform replaceStr=",replaceStr)

	local cIndex = 0
	local pos = 0
	for st,sp in function() return string.find(replaceStr,delimiter,pos,true) end do
		local s = string.sub(replaceStr, pos, st - 1)
		print("st sp",st,sp,"s=",s)
		table.insert(arr, s)
		pos = sp + 1
		cIndex = cIndex + 1
		if cIndex<= #pCnt then
			table.insert(arr,pCnt[cIndex])
		end

	end
	return arr
end

local ret = transform(str)


print("------------ transform is my target ----------------")

--Global.PrintTabKV(ret)


local myStr = "color,2,{$1}"

myStr = string.gsub(myStr,"[$]", "")

print("myStr=",myStr)



local s= "COLOR,2,{$1}"

print(string.find(s,"COLOR"))


local StringUtil = {}

--[[
替换占位符参数。
@str 包含占位符如：{1}的字符串
--]]
function StringUtil:replaceParams(str, ...)
    --替换参数
    local arg = {...}
    for i,v in ipairs(arg) do
        str = string.gsub(str, "{"..i.."}", v)
    end
    return str
end

function StringUtil:split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    local i = 1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

s = "你是谁的谁的{1}等级"

local ret = StringUtil:replaceParams(s,"<替换成我>")
print("-----------------ret---------------")

print(ret)


print("-----------------ret--22-------------")

local ret = StringUtil:split("1001#", "#")

Global.PrintTabKV(ret)








