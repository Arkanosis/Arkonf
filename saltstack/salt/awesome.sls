awesome_pkgs:
  pkg.installed:
    - pkgs:
      - awesome
{% if grains['os_family'] == 'Debian' %}
      - awesome-extra
{% endif %}
