publication_pkgs:
  pkg.installed:
    - pkgs:
      - hugo
{% if grains['os_family'] == 'Arch' %}
      - python-sphinx
{% else %}
      - python3-sphinx
{% endif %}
      - scribus
