@echo off
::要删除的路径
@set url=./as3/
::路径下的文件类型
@set file=.as
@echo clearAS3 begining.
@echo ------------------------
@lua clearLog.lua %url% %file%
@echo ------------------------
@echo clearAS3 end.
@echo ------------------------
pause