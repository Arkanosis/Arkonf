java_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - apache-ant
      - java8-openjdk
{% else %}
      - ant
      - openjdk-8-jdk
{% endif %}
      - maven
