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
{% if grains['host'] == 'bismuth' %}
        - http
        - https
        - ssh # mostly for rssht / sftp from hosts that are not using Wireguard
{% else %}
        - ssh # TODO remove once all hosts are reachable through Wireguard (use the home zone for sftp)
        - syncthing # TODO remove once all hosts are reachable through Wireguard
{% endif %}

{% if grains['host'] != 'bismuth' %}
home:
  firewalld.present:
    - name: home
    - default: False
    - services:
        - dhcpv6-client
        - llmnr # for local link hostname resolution by systemd-resolved
        # TODO qrcp
        #  - configure qrcp to bind on localhost (qrcp --interface lo) and fixed port (--port=9876)
        #  - configure nginx to reverse-proxify with https (for now on the same fixed port, see qrcp#169)
        #  - => no need for a specific qrcp service, everything passes through the https service (restricted to the home zone)
        - https # mostly for qrcp
        - mdns # for local link hostname resolution
        - rpcbind # for NFS
        - samba-client
        - ssh # mostly for sftp from hosts that are not using Wireguard
        - syncthing # TODO remove once all hosts are reachable through Wireguard
{% endif %}

trusted:
  firewalld.present:
    - name: trusted
    - default: False
    - interfaces:
        - lxcbr0

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