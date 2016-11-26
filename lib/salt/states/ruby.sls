{% set vars = pillar.get('vars') %}
rbenv-deps:
  pkg.installed:
    - names:
      - autoconf
      - automake
      - bison
      - build-essential
      - libbz2-dev
      - libmysqlclient-dev
      - libreadline6
      - libreadline6-dev
      - libsqlite3-dev
      - libssl-dev
      - libxml2-dev
      - libxslt1-dev
      - libyaml-dev
      - ruby-dev
      - zlib1g
      - zlib1g-dev
      # - libffi-dev
      # - libncurses5-dev

ruby-2.3.0:
  rbenv.installed:
    - user: {{ vars.deploy_user }}
    - default: True
    - require:
      - pkg: rbenv-deps

rbenv-vars:
  git.latest:
    - name: https://github.com/rbenv/rbenv-vars.git
    - target: /home/{{ vars.deploy_user }}/.rbenv/plugins/rbenv-vars
    - user: {{ vars.deploy_user }}
    - depth: 1
    - require:
      - rbenv: ruby-2.3.0

# {% set current_path = salt['environ.get']('PATH') %}
# {% set home = '/home/' + vars.deploy_user %}
# {% set rbenv_path = home + '/.rbenv'  %}
# rbenv-path:
#   environ.setenv:
#     - name: path
#     - value: {{ [rbenv_path + '/shims', rbenv_path + '/bin', current_path]|join(':') }}
#     - update_minion: True
#     - require:
#       - rbenv: ruby-2.3.0

bundler:
  gem.installed:
    - user: {{ vars.deploy_user }}
    # - ruby: '2.3.0'
    - require:
      # - environ: rbenv-path
      - rbenv: ruby-2.3.0

gem-deps:
  pkg.installed:
    - names:
      # curb
      - libcurl3
      - libcurl3-gnutls
      - libcurl4-openssl-dev
