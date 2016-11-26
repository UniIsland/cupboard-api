#!/bin/bash

cat > ${SALT_PATH}/minion <<EOF
file_client: local

file_roots:
  base:
    - ${SALT_PATH}/states
    - ${SALT_PATH}/formulas

pillar_roots:
  base:
    - ${SALT_PATH}/pillar
EOF

sudo cp ${SALT_PATH}/minion /etc/salt/minion

source ./.rbenv-vars

cat > ${SALT_PATH}/pillar/vars.sls <<EOF
vars:
  deploy_user: ${DEPLOY_USER}
  db_root_passwd: ${DB_ROOT_PASSWD}
  database_password: ${DATABASE_PASSWORD}
EOF

cat > ${SALT_PATH}/pillar/vars.yaml <<EOF
deploy_user: ${DEPLOY_USER}
db_root_passwd: ${DB_ROOT_PASSWD}
database_password: ${DATABASE_PASSWORD}
EOF
