#!/bin/bash

start_xrdp_services() {
  rm -rf /var/run/xrdp-sesman.pid
  rm -rf /var/run/xrdp.pid
  rm -rf /var/run/xrdp/xrdp-sesman.pid
  rm -rf /var/run/xrdp/xrdp.pid

  xrdp-sesman
  exec xrdp -n
}

stop_xrdp_services() {
  xrdp --kill
  xrdp-sesman --kill
  exit 0
}

echo Entrypoint script is Running...
echo

users=$(($#/3))
mod=$(($# % 3))

echo "users is $users"
echo "mod is $mod"

if [[ $# -eq 0 ]]; then
  echo "incorrect input. exiting..."
  echo "there should be 3 input parameters per user"
  exit
fi

echo "You entered $users users"

while [ $# -ne 0 ]; do
  useradd $1
  wait
  echo $1:$2 | chpasswd
  wait
  if [[ $3 == "yes" ]]
  then
    usermod -aG wheel $1
  fi
  wait
  echo "user '$1' is added"
  shift 3
done

echo -e "User add complete"

echo -e "starting xrdp services... \n"

trap "stop_xrdp_services" SIGKILL SIGTERM SIGHUP SIGINT EXIT
start_xrdp_services
