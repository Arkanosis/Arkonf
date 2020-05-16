search_pkgs:
  pkg.installed:
    - pkgs:
      - pdfgrep
{% if grains['os_family'] == 'Arch' %}
      - fd
      - the_silver_searcher
{% else %}
      - silversearcher-ag
{% endif %}
