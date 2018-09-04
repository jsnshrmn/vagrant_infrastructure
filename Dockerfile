FROM library/debian:9

RUN apt update && apt install -y openssh-server python-minimal sudo
RUN mkdir /var/run/sshd

# Configure insecure root user for Vagrant
RUN echo 'root:vagrant' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Add vagrant user
RUN adduser --quiet --disabled-password --shell /bin/bash --home /home/vagrant --gecos "User" vagrant
RUN echo 'vagrant:vagrant' | chpasswd

# Setup vagrant insecure key.
RUN mkdir -p /home/vagrant/.ssh
RUN echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key' >>/home/vagrant/.ssh/authorized_keys
RUN chown -R 'vagrant:vagrant' /home/vagrant/.ssh
RUN chmod 600 /home/vagrant/.ssh/authorized_keys
RUN chmod 700 /home/vagrant/.ssh

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


RUN echo 'vagrant         ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

#RUN mkdir -p /vagrant
#WORKDIR /vagrant
#ADD . /vagrant

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
