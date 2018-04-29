FROM kalilinux/kali-linux-docker

RUN apt-get update --fix-missing
RUN apt-get install -y kali-linux-full
RUN apt-get upgrade -y
WORKDIR /root
CMD ["/bin/bash"]
