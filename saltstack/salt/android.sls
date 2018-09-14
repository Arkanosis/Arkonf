android_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - android-tools
{% else %}
      - android-tools-adb
{% endif %}
