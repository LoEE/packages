#!/bin/sh /etc/rc.common
# (C) 2019 LoEE.pl

START=70

start() {
  servicedir=/tmp/service
  # services are kept in RAM so they have to be recreated on each startup
  mkdir -p "$servicedir"
  run-parts -a "$servicedir" /etc/service.d

  # this is a buffer for errors that can be read using ps(1)
  proclog="                                                                                                    "

  env - runsvdir "$servicedir" "$proclog" &
}
