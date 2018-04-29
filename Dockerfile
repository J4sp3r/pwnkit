FROM kalilinux/kali-linux-docker

RUN apt-get update --fix-missing
RUN apt-get install -y kali-linux-full
RUN apt-get update && apt-get install -y gobuster
WORKDIR /root
CMD ["/bin/bash"]
