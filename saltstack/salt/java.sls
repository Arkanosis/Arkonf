java_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - apache-ant
      - jdk8-openjdk
      - java-openjfx
{% else %}
      - ant
      - openjdk-8-jdk
      - openjfx
{% endif %}
      - maven
