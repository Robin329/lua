@echo off

::������,�������͵Ⱥ�֮�䲻���пո�
@set url=./log/ 
::Ҫ������ļ����ͺ�׺
@set file=.txt
@echo clearLog begining.
@echo ------------------------
@lua clearLog.lua %url% %file%
@echo ------------------------
@echo clearLog end.
@echo ------------------------
