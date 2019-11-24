FROM jasperboot/kali-full:latest

# Software tools
RUN apt-get update && apt-get install -y gobuster libcurl4-openssl-dev libssl-dev python3-pip

# Set the locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Python tools
RUN pip install --upgrade pip
RUN pip install --upgrade pwntools
RUN pip3 install --upgrade wfuzz
RUN pip3 install --upgrade z3-solver
RUN pip3 install --upgrade keystone-engine
RUN pip3 install --upgrade unicorn
RUN pip3 install --upgrade ropper
RUN pip3 install --upgrade git+https://github.com/arthaud/python3-pwntools.git
RUN pip3 install --upgrade uncompyle6

# Other tools
RUN git clone https://github.com/hugsy/gef.git .gef && \
    echo "source $(pwd)/.gef/gef.py" >> ~/.gdbinit

# Create work directories
RUN mkdir /root/workdir
RUN mkdir /root/tools
WORKDIR /root/tools

## Clone Github tools
RUN git clone https://github.com/Ganapati/RsaCtfTool.git
RUN cp /usr/share/wordlists/rockyou.txt.gz /root/tools && gunzip /root/tools/rockyou.txt.gz


WORKDIR /root/workdir
CMD ["/bin/bash"]
