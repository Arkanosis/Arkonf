android_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - android-tools
{% else %}
      - android-tools-adb
      - fdroidserver # TODO FIXME need it for ArchLinux as well
{% endif %}
