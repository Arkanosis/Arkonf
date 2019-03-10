mail_pkgs:
  pkg.installed:
    - pkgs:
      - isync
      - s-nail
      - ssmtp

/etc/ssmtp/ssmtp.conf:
  file.managed:
    - source: salt://mail/ssmtp.conf
    - template: jinja
    - group: mail
    - mode: 640

/etc/ssmtp/revaliases:
  file.managed:
    - source: salt://mail/revaliases
    - template: jinja
    - group: mail
    - mode: 640

{% if grains['os_family'] == 'Arch' %}
/usr/bin/ssmtp:
{% else %}
/usr/sbin/ssmtp:
{% endif %}
  file.managed:
    - user: root
    - group: mail
    - mode: 2755

workaround_for_19834:
  # Bug #19834: SaltStack can't change the group of a file
  # and its setgid bit at the same time
  file.managed:
  {% if grains['os_family'] == 'Arch' %}
    - name: /usr/bin/ssmtp
{% else %}
    - name: /usr/sbin/ssmtp
{% endif %}
    - mode: 2755

{% if grains['os_family'] == 'Debian' %}
/usr/bin/mail:
  file.symlink:
    - user: root
    - mode: 755
    - target: s-nail

/usr/bin/mailx:
  file.symlink:
    - user: root
    - mode: 755
    - target: s-nail
{% endif %}
