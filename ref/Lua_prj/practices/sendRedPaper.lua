
nowNum = os.time()
nowStr = tostring(nowNum):reverse()
math.randomseed(string.sub(nowStr,1,7))
function  send(num,money)
	local min = 0.1
	
	local counter = 1
	local srcMoney = money

	local getNum = 0
	getNum = math.random()*money
	getNum = math.floor(getNum)
	local money = money - getNum
	local leftMin = 0
	while true do
		leftMin = min*(num-1)
		if money>=leftMin then
			--有效的红包
			print("第",counter,"次 获得",getNum," 元 剩余",money,"leftMin=",leftMin)
			counter = counter + 1
			num = num - 1

		else
			--无效的红包
			money = money + getNum
		end
		if num<=0 then break end
		
		getNum = math.random()*money
		print("实际随机值",getNum)
		getNum = math.floor(getNum)
		money = money - getNum

	end
end

send(25,100)

