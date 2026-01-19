language_pkgs:
  pkg.installed:
    - pkgs:
      - hunspell
      - hunspell-fr
{% if grains['os_family'] == 'Arch' %}
      - words
{% else %}
      - wamerican
      - wfrench
{% endif %}