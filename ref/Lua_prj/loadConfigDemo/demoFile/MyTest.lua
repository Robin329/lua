
pays = {
			{
				{times=3,cost=100,name="aaa"},
				{times=3,cost=100,name="aaa"},
				{times=3,cost=100,name="aaa"},
			}

		}


local n = table.getn(pays);

print(n)

str = "*.*.*.times"

str,count = string.gsub(str, "%*%.", '');

print(str..",count="..count)
