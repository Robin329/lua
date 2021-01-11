
tutil = require "TimeUtil"

require "CommonFunc"



--print(tutil:formatSecond(sec),tutil:getFormat(t))

local ret = string.gsub("ymd:hms","%A","")

--print("ret=",ret)


local secondTab={
y=31104000,m=2592000,d=86400,h=3600,i=60,s=1

}

local dateTimeKeys={
	y="year",m="month",d="day",h="hour",i="min",s="sec"
}

function getDateInfoBySec(second,formatStr)
	local dateTab={
		year=0,
		month=0,
		day=0,
		hour=0,
		min=0,
		sec=0,
	}
	if formatStr==nil then
		formatStr ="ymdhis"
	else
		formatStr=string.gsub(formatStr,"%A","")
	end

	local minSec = 60
	local hourSec = 3600
	local daySec = hourSec*24
	local monSec = daySec*30
	local yearSec =monSec*12

	local function toint2(v)
		return math.floor(tonumber(v))
	end

	local leftSecd = second
	local len = string.len(formatStr)

	for i=1,len do
		local key = string.sub(formatStr,i,i)
		local bitSec = secondTab[key]
		dateTab[dateTimeKeys[key]] = toint2(leftSecd/bitSec)
		leftSecd = leftSecd%bitSec
	end

	return dateTab
end

local sec = 3600*24*30*12

local t =getDateInfoBySec(sec,"his")

Global.PrintTabKV(t)







