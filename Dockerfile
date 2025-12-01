FROM registry.access.redhat.com/ubi9/ubi
LABEL description="converts html to pdf"
MAINTAINER Syed Hassan <https://github.com/git-shassan>
    # Install dependencies

RUN dnf update -y && \
	dnf install -y wget libpng15 && \
        dnf clean all
RUN wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox-0.12.6-1.centos7.x86_64.rpm
RUN wget https://rpmfind.net/linux/almalinux/8.10/AppStream/x86_64/os/Packages/compat-openssl10-1.0.2o-4.el8_10.1.x86_64.rpm # src: https://rpmfind.net/linux/rpm2html/search.php?query=compat-openssl10
RUN dnf install -y ./compat-openssl10-1.0.2o-4.el8_10.1.x86_64.rpm 
RUN dnf install -y ./wkhtmltox-0.12.6-1.centos7.x86_64.rpm
