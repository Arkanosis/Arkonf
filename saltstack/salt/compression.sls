compression_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - p7zip
{% else %}
      - p7zip-full
{% endif %}
      - unrar
