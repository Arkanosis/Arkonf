java_pkgs:
  pkg.installed:
    - pkgs:
      - ant
{% if grains['os_family'] == 'Arch' %}
      - jdk8-openjdk
      - java-openjfx
{% else %}
      - openjdk-8-jdk
      - openjfx
{% endif %}
      - maven
