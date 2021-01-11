
print("返回当前时间戳",os.time())
print("程序执行的时间(秒)",os.clock())
print("格式化日期输出(返回一个表)",os.date("*t",os.time()))
print("格式化日期输出(返回星期几)",os.date("%w",os.time())) --星期日 是0