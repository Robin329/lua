@echo off
::Ҫɾ����·��
@set url=./as3/
::·���µ��ļ�����
@set file=.as
@echo clearAS3 begining.
@echo ------------------------
@lua clearLog.lua %url% %file%
@echo ------------------------
@echo clearAS3 end.
@echo ------------------------
pause