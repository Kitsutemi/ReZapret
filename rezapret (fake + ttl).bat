@echo off
chcp 65001 > nul

cd /d "%~dp0"
call service.bat status_zapret
call service.bat check_updates
call service.bat load_game_filter
echo:

set "BIN=%~dp0bin\"
set "LISTS=%~dp0lists\"
cd /d %BIN%

start "zapret: cfg1" /min "%BIN%winws.exe" --wf-tcp=80,443,2053,2083,2087,2096,8443,%GameFilter% --wf-udp=443,19294-19344,50000-50100,%GameFilter% ^
--filter-udp=443 --hostlist="%LISTS%list-general.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --ipset-exclude="%LISTS%ipset-exclude.txt" --dpi-desync=fake --dpi-desync-ttl=4 --orig-ttl=1 --new ^
--filter-udp=19294-19344,50000-50100 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-ttl=4 --new ^
--filter-tcp=2053,2083,2087,2096,8443 --hostlist-domains=discord.media --dpi-desync=fake --dpi-desync-ttl=4 --dpi-desync-fooling=ts --new ^
--filter-tcp=443 --hostlist="%LISTS%list-google.txt" --dpi-desync=fake --dpi-desync-ttl=4 --new ^
--filter-tcp=25565 --dpi-desync=fake --dpi-desync-ttl=4 --dpi-desync-any-protocol=1 --new ^
--filter-tcp=80,443 --hostlist="%LISTS%list-general.txt" --dpi-desync=fake --dpi-desync-ttl=4 --new ^
--filter-udp=443 --ipset="%LISTS%ipset-all.txt" --dpi-desync=fake --dpi-desync-ttl=4 --new ^
--filter-tcp=80,443,%GameFilter% --ipset="%LISTS%ipset-all.txt" --dpi-desync=fake --dpi-desync-ttl=4 --new ^
--filter-udp=%GameFilter% --dpi-desync=fake --dpi-desync-ttl=4 --dpi-desync-any-protocol=1