pass_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - keepassx2
{% else %}
      - keepassx
{% endif %}
      - pass
      - pwgen
