for /f "delims=" %%a in ('dir /s/b/ad') do set/a a+=1
for /f "delims=" %%a in ('dir /s/b/a-d') do set/a b+=1
echo.ͳ�ƽ������ǰĿ¼�ļ�����%b%   �ļ�����: %a%
pause>nul