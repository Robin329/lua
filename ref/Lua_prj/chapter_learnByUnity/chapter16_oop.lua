--类定义
Account = {
    balance = 0,
    withdraw = function (self,v)
        
        if self.balance>=v then
            self.balance = self.balance - v;
        else
            print("余额不足")
        end
        return self.balance;
    end

}

--存钱
function Account:deposit(v)
    self.balance = self.balance + v;
    print("deposit balance",self.balance)
end

function Account:new(obj)
    obj = obj or {}
    setmetatable(obj,self) --设置自身为元表
    self.__index = self; --设置自身为 __index 域
    return obj;
end

a1 = Account:new(); --实例化对象
a1:deposit(100) --通过冒号操作符 可以省去传self的麻烦
print("a1.balance",a1.balance,a1.withdraw(a1,100))

--实现多继承
local function search(k,plist)
    --搜索函数 主要是从plist一个类列表中搜索k的值 是否存在
    for i = 1, table.getn(plist), 1 do
        
        local v = plist[i][k]
        print("search k",k,v)
        if v then return v end
    end
    
end

--通过该方法 创建继承多个类的类
function createClass(...) 
    local c = {}
    setmetatable(c,{__index=function (t,k)
        return search(k,arg)
    end})
    c.__index = c;
    function c:new(o)
        o = o or {}
        setmetatable(o,c)
        return o
    end
    return c;
end

Named = {}
function Named:getname()
    return self.name;
end

function Named:setname(n)
    self.name = n;
    
end

NameAccount = createClass(Account,Named) --先创建类

na1 = NameAccount:new({name="Paul"}); --创建实例
na1:deposit(100)
na1:withdraw(120);

