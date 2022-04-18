processing_pkgs:
  pkg.installed:
    - pkgs:
      - csvkit
      - datamash
      - jq
{% if grains['os_family'] == 'Arch' %}
      - sd
{% endif %}
      - units
      - xmlstarlet
