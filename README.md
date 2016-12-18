# GNU/Linux config files

This repo is made so I can easily symlink all my config files into needed locations
but from one single well structured location. Configs should be linked with bash
scripts. Scripts are located in the first level of directories and named \_\_symlink.sh.
The plan is to make a bash script that will execute all those bash scripts and they
will link the files. Don't use .configxxx notation for config files in the repo but
name them without the dot (ex. ".vimrc" will be "vimrc").

## Installation
You can easily install the config files by running the setup scripts located in
`setups` folder (if you're using Ubuntu). This will install all the tools I use
and link the config files where they need to be (but it will force my folder
structure upon you). There is a few manual steps:
* Add plank to autostart (the command is just `plank`)
* Set the latitude and longitude for F.lux (or switch it to Redshift)

## License
Config files are licensed under the [MIT license](./LICENSE.md).


