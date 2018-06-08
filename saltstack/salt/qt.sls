qt_pkgs:
  pkg.installed:
    - pkgs:
      # Mostly for QRegovar
{% if grains['os_family'] == 'Arch' %}
      - qt5-charts
      - qt5-graphicaleffects
      - qt5-quickcontrols2
      - qt5-websockets
{% else %}
      - qml-module-qtcharts
      - qml-module-qtgraphicaleffects
      - qml-module-qtquick-controls2
      - qml-module-qtwebsockets
{% end %}
