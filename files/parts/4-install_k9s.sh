# Versions
export WORKDIR=~/
export GO_INSTALL_VERSION=1.20.4
export K9S_INSTALL_VERSION=v0.27.4

# Install git and wget
yum install git wget -y
yum groupinstall "Development Tools" -y

# Go to workdir
cd $WORKDIR

# Install GOLang
wget https://go.dev/dl/go$GO_INSTALL_VERSION.linux-amd64.tar.gz -O go.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go.linux-amd64.tar.gz && rm -rf go.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
go version

# Install k9s
git clone https://github.com/derailed/k9s.git --depth 1 --branch $K9S_INSTALL_VERSION
cd k9s && make build
export PATH=$PATH:$WORKDIR/k9s/execs
echo 'export PATH=$PATH:$WORKDIR/k9s/execs' >> ~/.bashrc
