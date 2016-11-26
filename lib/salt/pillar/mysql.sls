{% import_yaml "vars.yaml" as vars %}
mysql:
  server:
    root_user: 'root'
    root_password: {{ vars.db_root_passwd }}
  databases:
    - cupboard_dev
    - cupboard_prod
  user:
    cupboard:
      password: {{ vars.database_password }}
      host: localhost
      databases:
        - database: cupboard_dev
          grants: ['all privileges']
        - database: cupboard_prod
          grants: ['all privileges']
