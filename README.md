# saleone's full system configuration

Check how it looks in the [screeshots](#screenshots) section.

## Installation

Either use [Ansible playbook](./ansible/setup_pb.yml) during the minimal setup
of Fedora or run [link_configs script](./scripts/link_configs) if you already
have system installed.

## Software
Repository hosts my configurations for the following software:
* [Bash](./configurations/bashrc)
* [Compton](./configurations/compton.conf)
* [System default fonts](./configurations/fonts.conf)
* [Git](./configurations/gitconfig)
* [Redshift](./configurations/redshift.conf)
* [Vim/Neovim](./configurations/vimrc) (uses neovim dirs and symlinks for vim support)

To have the complete enviroment I use the following [suckless utilities](https://suckless.org/):
* Window Manager - [dwm](https://github.com/saleone/dwm)
* Terminal - [st](https://github.com/saleone/st)
* App Launcher - [dmenu](https://github.com/saleone/dmenu)
* Screen locker - [slock](https://github.com/saleone/slock)

**All of these are changed in some way and are not what suckless provides.**

Script directory ([./scripts](./scripts)) contains useful scripts for random stuff.
If you want a nice and simple status bar script check [./scripts/status](./scripts/status).

## License
Everything is licenced under the terms of [MIT license](./LICENSE.md).

## <a name='screenshots'></a>Screenshots

![Clean setup](https://i.imgur.com/tPcCIHc.jpg)

---

![Busy setup](https://i.imgur.com/leBGVN2.png)

