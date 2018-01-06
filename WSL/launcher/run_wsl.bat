.\seemless.xlaunch
ping 127.0.0.1 -n 2 > nul

bash -c "bash --rcfile <(echo '. ~/.bashrc; i3')"
