webbrowser_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - chromium
{% else %}
      - chromium-browser
{% endif %}
      - firefox
{% if grains['os_family'] == 'Arch' %}
      - firefox-i18n-fr
{% else %}
      - firefox-locale-fr
{% endif %}

/home/arkanosis/.cache/mozilla:
  file.symlink:
    - target: /tmp/.mozilla-cache_arkanosis
    - user: arkanosis
