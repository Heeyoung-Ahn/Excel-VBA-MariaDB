@echo off

set HOUR=%time:~0,2%
set MINUTE=%time:~3,2%
set SECOND=%time:~6,2%

echo Running dump...
"C:\Program Files\MariaDB 10.4\bin\"mysqldump --routines -u������ -p��й�ȣ --all-databases --result-file="D:\%DATE% %HOUR%�� %MINUTE%�� %SECOND%��.sql"
echo Done!
