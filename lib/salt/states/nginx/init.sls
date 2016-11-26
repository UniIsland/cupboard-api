{% set vars = pillar.get('vars') %}
{% set base_dir = '/home/' + vars.deploy_user + '/deploy/cupboard-api' %}
cupboard_prod:
  file.managed:
    - name: /etc/nginx/sites-available/cupboard-api_prod
    - source: salt://nginx/cupboard-api_production
    - makedirs: True
    - template: jinja
    - defaults:
      base_dir: {{ base_dir }}

cupboard_prod_enabled:
  file.symlink:
    - name: /etc/nginx/sites-enabled/cupboard-api_prod
    - target: /etc/nginx/sites-available/cupboard-api_prod
    - makedirs: True
