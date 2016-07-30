awesome_pkgs:
  pkg.installed:
    - pkgs:
      - awesome
{% if grains['os_family'] == 'Debian' %}
      - awesome-extra
{% endif %}

/home/arkanosis/.config/awesome:
  file.symlink:
    - target: /home/arkanosis/Arkonf/awesome
    - user: arkanosis
