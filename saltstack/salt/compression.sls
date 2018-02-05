compression_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - p7zip
{% else %}
      - mpack
      - p7zip-full
{% endif %}
      - unrar
      - unzip
