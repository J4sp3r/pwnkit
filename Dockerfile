FROM kalilinux/kali-rolling:latest

# Software tools
RUN apt-get update && apt-get install -y \
    binwalk \
    cmake \
    dirb \
    exploitdb \
    fcrackzip \
    gdb \
    git \
    hashcat \
    john \
    joomscan \
    libcurl4-openssl-dev \
    libgmp3-dev \
    libmpc-dev \
    libssl-dev \
    locales \
    metasploit-framework \
    nmap \
    php \
    php-mysql \
    python3-pip \
    screen \
    smbmap \
    sqlmap \
    wfuzz \
    wordlists \
    zsh

RUN apt-get autoremove

# Set the locale
RUN locale-gen "en_US.UTF-8"
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Python tools
RUN pip3 install --upgrade pip

RUN pip3 install --upgrade GMPY2
RUN pip3 install --upgrade keystone-engine
RUN pip3 install --upgrade pwntools
RUN pip3 install --upgrade PyCrypto
RUN pip3 install --upgrade requests
RUN pip3 install --upgrade ropper
RUN pip3 install --upgrade six
RUN pip3 install --upgrade SymPy
RUN pip3 install --upgrade uncompyle6
RUN pip3 install --upgrade unicorn
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

## Clone Github tools
RUN git clone https://github.com/Ganapati/RsaCtfTool.git

# Cleanup and config
RUN chsh -s $(which zsh)
RUN cp /usr/share/wordlists/rockyou.txt.gz /tools && gunzip /tools/rockyou.txt.gz
COPY ./files/launch-in-session.sh /tools/launch-in-session.sh
COPY ./files/.zshrc /root/.zshrc

WORKDIR /workdir
CMD ["/bin/zsh"]
