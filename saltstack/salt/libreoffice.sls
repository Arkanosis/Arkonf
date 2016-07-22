libreoffice_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - libreoffice-fresh
      - libreoffice-fresh-fr
{% else %}
      - libreoffice
{% endif %}
 