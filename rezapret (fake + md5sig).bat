@echo off
chcp 65001 > nul
cd /d "%~dp0"

call service.bat status_zapret
call service.bat check_updates
call service.bat load_game_filter

set "BIN=%~dp0bin\"
set "LISTS=%~dp0lists\"
cd /d %BIN%

start "zapret: md5sig" /min "%BIN%winws.exe" --wf-tcp=80,443,2053,2083,2087,2096,8443,%GameFilter% --wf-udp=443,19294-19344,50000-50100,%GameFilter% ^
--filter-udp=443 --hostlist="%LISTS%list-general.txt" --dpi-desync=fake --dpi-desync-fooling=md5sig --new ^
--filter-udp=19294-19344,50000-50100 --dpi-desync=fake --dpi-desync-fooling=md5sig --new ^
--filter-tcp=2053,2083,2087,2096,8443 --dpi-desync=fake --dpi-desync-fooling=md5sig --new ^
--filter-tcp=443 --dpi-desync=fake --dpi-desync-fooling=md5sig --new ^
--filter-tcp=25565 --dpi-desync=fake --dpi-desync-any-protocol=1 --new ^
--filter-tcp=80,443 --dpi-desync=fake --dpi-desync-fooling=md5sig --new ^
--filter-udp=443 --dpi-desync=fake --dpi-desync-fooling=md5sig --new ^
--filter-tcp=80,443,%GameFilter% --dpi-desync=fake --dpi-desync-fooling=md5sig --new ^
--filter-udp=%GameFilter% --dpi-desync=fake --dpi-desync-fooling=md5sig --dpi-desync-any-protocol=1