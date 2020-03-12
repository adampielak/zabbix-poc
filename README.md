# How to initialize your ansible environment

## Install miniconda3 into /opt with root privileges (1 time on the server)

    # sudo su -
    # curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o Miniconda3-latest-Linux-x86_64.sh
    # chmod +x Miniconda3-latest-Linux-x86_64.sh
    # ./Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3
    # rm Miniconda3-latest-Linux-x86_64.sh
    # logout

## Initialize your python environment

    # /opt/miniconda3/bin/conda init bash
    # logout
    # python --version

## Install ansible and all python modules required

    # pip install ansible zabbix-api 

## Clone git repository with ansible-playbook

    # git clone git@github.com:SimBou/zabbix-poc.git

## Install roles dependencies

    # ansible-galaxy install -p roles -r roles/requirements.yml



