awesome_pkgs:
  pkg.installed:
    - pkgs:
      - awesome
{% if grains['os_family'] == 'Debian' %}
      - awesome-extra
{% endif %}

/home/arkanosis/.config/awesome:
  file.symlink:
{% if grains['os_family'] == 'Arch' %}
    - target: /home/arkanosis/Arkonf/awesome4
{% else %}
    - target: /home/arkanosis/Arkonf/awesome
{% endif %}
    - user: arkanosis
