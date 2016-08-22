banner_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - banner
{% else %}
      - sysvbanner
{% endif %}

