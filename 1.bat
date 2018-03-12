for /f "delims=" %%a in ('dir /s/b/ad') do set/a a+=1
for /f "delims=" %%a in ('dir /s/b/a-d') do set/a b+=1
echo.统计结果：当前目录文件数：%b%   文件夹数: %a%
pause>nul