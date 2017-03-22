#!/bin/sh
PWD=`pwd`
export PATH=$PATH:$PWD/.erlang.mk/rebar;
make elixir_clean
make
