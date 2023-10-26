communication_pkgs:
  pkg.installed:
    - pkgs:
      - mutt
      - pidgin
{% if grains['os_family'] == 'Arch' %}
      - signal-desktop
      - teamspeak3
{% endif %}
      - thunderbird
{% if grains['os_family'] == 'Arch' %}
      - thunderbird-i18n-fr
{% else %}
      - thunderbird-l10n-fr
{% endif %}
      - weechat

/usr/bin/irc:
  file.managed:
    - source: salt://communication/irc
    - mode: 755
