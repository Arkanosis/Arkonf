security_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - arch-audit
{% else %}
      - cron-apt
      - debsecan
{% endif %}
      - fail2ban
      - firewalld
      - logwatch
{% if grains['os_family'] != 'Arch' %}
      - portsentry
{% endif %}

fail2ban:
  service.running:
    - enable: True

firewalld:
  service.running:
    - enable: True

{% if grains['os_family'] != 'Arch' %}
portsentry:
  service.running:
    - enable: True
{% endif %}

public:
  firewalld.present:
    - name: public
    - default: True
    - services:
        - dhcpv6-client
        - ssh
        - syncthing
        # TODO handle qrcp:
        #  - configure qrcp to bind on localhost (qrcp --interface lo) and fixed port (--port=9876)
        #  - configure nginx to reverse-proxify with https (for now on the same fixed port, see qrcp#169)
        #  - add a firewalld service file for qrcp
        #  - open the firewalld qrcp service

{% if grains['os_family'] != 'Arch' %}
/etc/cron-apt/config:
  file.managed:
    - source: salt://security/cron-apt-config
    - template: jinja
    - mode: 755

/etc/cron-apt/action.d/3-download:
  file.managed:
    - source: salt://security/cron-apt-action-3-download
    - mode: 644

/etc/cron.daily/logwatch:
  file.managed:
    - source: salt://security/logwatch-cron
    - template: jinja
    - mode: 755
{% endif %}

/etc/fail2ban/jail.local:
  file.managed:
    - source: salt://security/fail2ban-jail.local
    - template: jinja
    - mode: 644

{% if grains['os_family'] != 'Arch' %}
/etc/portsentry/portsentry.ignore.static:
  file.managed:
    - source: salt://security/portsentry.ignore.static
    - template: jinja
    - mode: 644
{% endif %}