webbrowser_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - chromium
{% endif %}
{% if grains['os_family'] == 'Debian' %}
      - firefox-esr
{% else %}
      - firefox
{% endif %}
{% if grains['os_family'] == 'Arch' %}
      - firefox-developer-edition
      - firefox-i18n-fr
      - geckodriver
{% elif grains['os_family'] == 'Debian' %}
      - firefox-esr-l10n-fr
{% else %}
      - firefox-locale-fr
{% endif %}

{% if grains['mem_total'] > 7000 %}
/home/arkanosis/.cache/mozilla:
  file.symlink:
    - target: /tmp/.mozilla-cache_arkanosis
    - user: arkanosis
{% endif %}
