--第九章 协程

function fact(n)
    --print("n",n)
    
    if n==0 then
        return 1
    else
        return n+fact(n-1)
    end
    
end

-- print(fact(10))

co = coroutine.create( fact ) --创建协程

status = coroutine.status( co )
print("status",status);
coroutine.resume( co,10)