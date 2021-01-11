print("-- 开始清理旧的文件 --")

require "lfs"

--递归查找
function findindir (path, wefind, r_table, intofolder)
    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            local f = path..'\\'..file            
            if string.find(f, wefind) ~= nil then             
                table.insert(r_table, f)
            end
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
            if attr.mode == "directory" and intofolder then
                findindir (f, wefind, r_table, intofolder)          
            end
        end
    end
end

-- arg 是lua保存cmd命令传过来的参数

local currentFolder = arg[1] --[[./log]]
local fileType = arg[2] 
-------------------------------------
local input_table = {}
findindir(currentFolder, "%"..fileType, input_table, false)--查找txt文件
i=1
while input_table[i]~=nil do
local url = input_table[i]
i=i+1
os.remove(url)
print("文件"..url..",已经被清理.")
end
i=i-1
print("---本次共清理了"..i.."个文件.")

print(arg[1], arg[2])
--[[
--读取命令传过来的参数
print(arg[1], arg[2])
for i, v in ipairs(arg) do
	print("输出命令行的参数:",v) 
end
--]]