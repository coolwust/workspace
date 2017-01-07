FROM fedora:25

# Packaged dependencies
RUN dnf -y update && dnf -y install \
	curl \
	tar \
	less \
	man \
	procps-ng \
	vim \
	tmux \
	ranger \
	git \
	gcc \
	docker

WORKDIR /root

COPY vimrc .vimrc
COPY tmux.conf .tmux.conf
COPY gitignore .config/git/ignore

# Install dropbox
RUN curl -fsSL "https://www.dropbox.com/download?plat=lnx.x86_64" | tar -xzf - \
       	&& mv .dropbox-dist /opt/dropbox

# Install Go
ENV GO_VERSION 1.7.4
RUN curl -fsSL "https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz" | tar -C /opt -xzf - \
	&& mkdir -p ~/Documents/go \
	&& git clone "https://github.com/fatih/vim-go.git" ~/.vim/pack/plugins/start/vim-go
ENV PATH /opt/go/bin:$PATH
ENV GOPATH ~/Documents/go

# Install Node.js
ENV NODE_VERSION v7.3.0
RUN curl -fsSL "https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz" | tar -Jxf - \
	&& mv node-${NODE_VERSION}-linux-x64 /opt/node
ENV PATH /opt/node/bin:$PATH

# Install TypeScript
RUN npm install -g typescript \
	&& git clone "https://github.com/leafgarland/typescript-vim.git" ~/.vim/pack/plugins/start/typescript-vim

ENTRYPOINT ["/bin/bash"]
