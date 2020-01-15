@echo off

set HOUR=%time:~0,2%
set MINUTE=%time:~3,2%
set SECOND=%time:~6,2%

echo Running dump...
"C:\Program Files\MariaDB 10.4\bin\"mysqldump --routines -u계정명 -p비밀번호 --all-databases --result-file="D:\%DATE% %HOUR%시 %MINUTE%분 %SECOND%초.sql"
echo Done!
