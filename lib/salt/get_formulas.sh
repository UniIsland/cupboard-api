#!/bin/bash

CWD=$PWD
SALT_DIR=`dirname $0`
FORMULA_DIR="$SALT_DIR/formulas"

mkdir -p $FORMULA_DIR
cd $FORMULA_DIR

[ -d ./mysql ] || {
  git clone --depth 1 https://github.com/saltstack-formulas/mysql-formula.git
  mv mysql-formula/mysql .
  rm -rf mysql-formula
}

# [ -d ./node ] || {
#   git clone --depth 1 git@github.com:saltstack-formulas/node-formula.git
#   mv node-formula/node .
#   rm -rf node-formula
# }
