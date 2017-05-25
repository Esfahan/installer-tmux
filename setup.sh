#!/bin/bash
TMUX_VERSION=$1

if [ -z "${TMUX_VERSION}" ]; then
  TMUX_VERSION='2.4'
fi

echo "Installing tmux-${TMUX_VERSION}..."

# dependencies
sudo yum -y install gcc kernel-devel make ncurses-devel

# libevent
LIBEVENT='libevent-2.0.21-stable'
if [ -e "/tmp/${LIBEVENT}" ]; then
  echo "${LIBEVENT} is already installed. skipping..."
else
  curl -L https://github.com/downloads/libevent/libevent/${LIBEVENT}.tar.gz --output /tmp/${LIBEVENT}.tar.gz
  tar xvzf /tmp/${LIBEVENT}.tar.gz -C /tmp
  cd /tmp/${LIBEVENT}/ && sudo ./configure --prefix=/usr/local
  cd /tmp/${LIBEVENT}/ && sudo make && sudo make install
fi

# tmux
TMUX="tmux-${TMUX_VERSION}"
if [ -e "/tmp/${TMUX}" ]; then
  echo "${TMUX} is already installed. skipping..."
else
  curl -L https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/${TMUX}.tar.gz --output /tmp/${TMUX}.tar.gz
  tar xvzf /tmp/${TMUX}.tar.gz -C /tmp
  cd /tmp/${TMUX}/ && sudo LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
  cd /tmp/${TMUX}/ && sudo make && sudo make install
fi


INSTALLED=`/usr/local/bin/tmux -V`
echo "Installed: ${INSTALLED}"
