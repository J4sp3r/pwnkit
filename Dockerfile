FROM kalilinux/kali-linux-docker

RUN apt-get update --fix-missing
RUN apt-get install -y kali-linux-full
RUN apt-get upgrade -y
RUN apt-get install -y gobuster
WORKDIR /root
CMD ["/bin/bash"]
