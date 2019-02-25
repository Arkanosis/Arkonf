space_pkgs:
  pkg.installed:
    - pkgs:
      - dfc
      - ncdu
{% if grains['oscodename'] != 'stretch' %} # Only available starting with buster
      - rmlint
{% endif %}
