include:
  - python

processing_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] != 'Arch' %}
      - datamash
{% endif %}
      - jq
{% if grains['os_family'] != 'Arch' %}
      - python3-csvkit
{% endif %}
      - units
      - xmlstarlet
