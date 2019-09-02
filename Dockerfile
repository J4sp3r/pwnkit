FROM kalilinux/kali-linux-docker

# Install kali stuff
RUN apt-get update --fix-missing
RUN apt-get install -y kali-linux-full

# Software tools
RUN apt-get update && apt-get install -y gobuster
RUN apt-get install -y libssl-dev libcurl4-openssl-dev

# Python tools
RUN pip install --upgrade pip
RUN pip install --upgrade pwntools
RUN pip3 install --upgrade wfuzz
RUN pip3 install --upgrade z3-solver
RUN pip3 install --upgrade git+https://github.com/arthaud/python3-pwntools.git

# Create work directories
RUN mkdir /root/workdir
RUN mkdir /root/tools
WORKDIR /root/tools

## Clone Github tools
RUN git clone https://github.com/Ganapati/RsaCtfTool.git


WORKDIR /root/workdir
CMD ["/bin/bash"]
