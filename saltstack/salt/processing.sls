include:
  - python

processing_pkgs:
  pkg.installed:
    - pkgs:
      - datamash
      - jq
{% if grains['os_family'] != 'Arch' %}
      - python3-csvkit
{% endif %}
      - units
      - xmlstarlet
