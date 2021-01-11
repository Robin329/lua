@echo off

::批处理,变量名和等号之间不能有空格
@set url=./log/ 
::要清理的文件类型后缀
@set file=.txt
@echo clearLog begining.
@echo ------------------------
@lua clearLog.lua %url% %file%
@echo ------------------------
@echo clearLog end.
@echo ------------------------
