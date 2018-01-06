:: Adding the location of the script to PATH allows us to run
:: WSL from Run or searching it in Start Menu
%~dp0\seemless.xlaunch
bash -c "bash --rcfile <(echo '. ~/.bashrc; i3')"