communication_pkgs:
  pkg.installed:
    - pkgs:
      - mutt
      - pidgin
      - thunderbird
{% if grains['os_family'] == 'Arch' %}
      - thunderbird-i18n-fr
{% else %}
      - thunderbird-locale-fr
{% endif %}
      - weechat

/usr/bin/irc:
  file.managed:
    - source: salt://communication/irc
    - mode: 755
