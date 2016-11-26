{% set vars = pillar.get('vars') %}
oh_my_zsh:
  git.latest:
    - name: git://github.com/robbyrussell/oh-my-zsh.git
    - target: /home/{{ vars.deploy_user }}/.oh-my-zsh
    - user: {{ vars.deploy_user }}
    - depth: 1

zsh-theme:
  file.managed:
    - name: /home/{{ vars.deploy_user }}/.oh-my-zsh/custom/themes/t1.zsh-theme
    - source: https://github.com/UniIsland/production-ready/raw/master/fork/oh-my-zsh/custom/themes/t1.zsh-theme
    - user: {{ vars.deploy_user }}
    - makedirs: True
    - source_hash: md5=00a5a64762e8f6c83310b380ddb24e18
    - skip_verify: True
    - require:
      - git: oh_my_zsh

zshenv:
  file.managed:
    - name: /etc/zsh/zshenv
    - source: salt://zsh/zshenv

zshrc:
  file.managed:
    - name: /home/{{ vars.deploy_user }}/.zshrc
    - source: salt://zsh/zshrc
    - user: {{ vars.deploy_user }}
    - require:
      - git: oh_my_zsh
      - file: zsh-theme

gemrc:
  file.managed:
    - name: /home/{{ vars.deploy_user }}/.gemrc
    - source: salt://zsh/gemrc
    - user: {{ vars.deploy_user }}

bundle_config:
  file.managed:
    - name: /home/{{ vars.deploy_user }}/.bundle/config
    - source: salt://zsh/bundle_config
    - user: {{ vars.deploy_user }}
    - makedirs: True
