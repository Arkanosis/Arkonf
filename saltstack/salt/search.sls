search_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - fd
{% endif %}
      - pdfgrep
      - ripgrep
{% if grains['os_family'] == 'Arch' %}
      - the_silver_searcher
{% else %}
      - silversearcher-ag
{% endif %}
