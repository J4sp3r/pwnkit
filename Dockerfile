FROM kalilinux/kali-rolling:latest

# Software tools
RUN dpkg --add-architecture i386
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get update

# This is some magic to prevent interactive prompts during installation in 'keyboard-configuration'
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get install -y -q

RUN apt-get install -y binwalk cmake libcurl4-openssl-dev libgmp3-dev libmpc-dev libssl-dev locales metasploit-framework

RUN apt-get install -y crackmapexec
RUN apt-get install -y dirb
RUN apt-get install -y dnsutils
RUN apt-get install -y enum4linux
RUN apt-get install -y exploitdb
RUN apt-get install -y fcrackzip
RUN apt-get install -y ftp-ssl
RUN apt-get install -y gdb
RUN apt-get install -y git
RUN apt-get install -y gobuster
RUN apt-get install -y iputils-ping
RUN apt-get install -y john
RUN apt-get install -y joomscan
RUN apt-get install -y libc6-i386
RUN apt-get install -y libimage-exiftool-perl
RUN apt-get install -y libpcre++-dev
RUN apt-get install -y ltrace
RUN apt-get install -y man
RUN apt-get install -y nano
RUN apt-get install -y ncat
RUN apt-get install -y nfs-common
RUN apt-get install -y nikto
RUN apt-get install -y nishang
RUN apt-get install -y nmap
RUN apt-get install -y pcregrep
RUN apt-get install -y php
RUN apt-get install -y php-mysql
RUN apt-get install -y pngtools
RUN apt-get install -y python2
RUN apt-get install -y python2-dev
RUN apt-get install -y python3-dev
RUN apt-get install -y python3-pip
RUN apt-get install -y screen
RUN apt-get install -y smbmap
RUN apt-get install -y sqlmap
RUN apt-get install -y sqsh
RUN apt-get install -y sslscan
RUN apt-get install -y strace
RUN apt-get install -y telnet
RUN apt-get install -y tree
RUN apt-get install -y vim
RUN apt-get install -y wfuzz
RUN apt-get install -y wine
RUN apt-get install -y wine32
RUN apt-get install -y winexe
RUN apt-get install -y wordlists
RUN apt-get install -y xxd
RUN apt-get install -y zsh

RUN apt-get autoremove -y

# Set the locale
RUN sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
RUN locale-gen "en_US.UTF-8"
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Python tools
COPY get-pip.py /tmp/get-pip.py
RUN python2 /tmp/get-pip.py
RUN rm /tmp/get-pip.py
RUN pip2 install --upgrade pip
RUN pip2 install --upgrade PyCrypto

RUN alias python=python3
RUN alias pip=pip3
RUN pip3 install --upgrade pip

RUN pip3 install --upgrade angr
RUN pip3 install --upgrade GMPY2
RUN pip3 install --upgrade keystone-engine
RUN pip3 install --upgrade Pillow
RUN pip3 install --upgrade pwntools
RUN pip3 install --upgrade pycryptodome
RUN pip3 install --upgrade requests
RUN pip3 install --upgrade ropper
RUN pip3 install --upgrade six
RUN pip3 install --upgrade tqdm
RUN pip3 install --upgrade uncompyle6
RUN pip3 install --upgrade unicorn
RUN pip3 install --upgrade urllib3
RUN pip3 install --upgrade wfuzz
RUN pip3 install --upgrade z3-solver

# Other tools
RUN git clone https://github.com/hugsy/gef.git .gef && \
    echo "source $(pwd)/.gef/gef.py" >> ~/.gdbinit

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Create work directories
RUN mkdir /workdir
RUN mkdir /tools
WORKDIR /tools

# Clone Github tools
RUN git clone https://github.com/Ganapati/RsaCtfTool.git
RUN git clone https://github.com/volatilityfoundation/volatility.git
RUN alias volatility="python2 /tools/volatility/vol.py"

# Cleanup and config
RUN chsh -s $(which zsh)
RUN cp /usr/share/wordlists/rockyou.txt.gz /tools && gunzip /tools/rockyou.txt.gz
COPY ./files/launch-in-session.sh /tools/launch-in-session.sh
COPY ./files/.zshrc /root/.zshrc

WORKDIR /workdir
CMD ["/bin/zsh"]
