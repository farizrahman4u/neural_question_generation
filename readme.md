# Neural Question Generation


### Original project : https://github.com/xinyadu/nqg


## Install luajit + torch

* `git clone https://github.com/torch/distro.git ~/torch --recursive`
* `cd ~/torch; bash install-deps;`
* `./install.sh`
* `source ~/.bashrc`


## Install tds

* `luarocks install tds`

Similarly, if any packages are missing, use `luarocks install <package-name>`.

## Download model file

* [model](https://drive.google.com/file/d/16Gi1oZr3mEGMEUCsOQ3whFfDlv8IAyzG/view?usp=sharing)

## Generating questions

* Enter sentences in `input.txt`; one sentence per line.
* `th run.lua`
* Output will be printed on the screen as well as written to `output.txt`


## Server

* Install xavante : `luarocks install restserver-xavante`
* Start server : `th server.lua`
* Go to `localhost:8080/generate_question?input=xyz+is+the+president+of+abcd` on browser to test
* You can change port number and service name in `server.lua`

### Paper

* [arxiv](https://arxiv.org/abs/1705.00106)
