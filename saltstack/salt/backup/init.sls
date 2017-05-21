backup_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - ddrescue
{% else %}
      - gddrescue
{% endif %}
      - rsnapshot

/etc/rsnapshot.conf:
  file.managed:
    - source: salt://backup/rsnapshot.conf
    - template: jinja
    - mode: 644
