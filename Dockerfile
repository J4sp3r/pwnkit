FROM kalilinux/kali-linux-docker


RUN apt-get update --fix-missing
RUN apt-get install -y kali-linux-full
RUN apt-get update && apt-get install -y gobuster
RUN apt-get install -y libssl-dev libcurl4-openssl-dev

RUN pip install --upgrade pip
RUN pip install --upgrade pwntools
RUN pip3 install --upgrade wfuzz

CMD mkdir /root/workdir
CMD mkdir /root/apps
WORKDIR /root/apps

## Clone Github repos
RUN git clone https://github.com/Ganapati/RsaCtfTool.git


WORKDIR /root/workdir
CMD ["/bin/bash"]
