search_pkgs:
  pkg.installed:
    - pkgs:
      - pdfgrep
{% if grains['os_family'] != 'Arch' %}
      - silversearcher-ag
{% endif %}
