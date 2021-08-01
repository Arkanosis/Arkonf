# TODO fake-factory (faker)

# VM

python_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      # VM
      - python
      - cython
      # Installer
      - python-pip
      # Debugger
      - python-pudb
      # Modules
      - python-click
      - python-jinja
      - python-language-server
      - python-llfuse
      - python-openpyxl
      - python-poetry
      - python-progressbar
      - python-yaml
{% else %}
      # VM
      - python3
      - cython3
      - python3-dev
      # Installer
      - python3-pip
      # Debugger
      - python3-pudb
      # Modules
      - python3-click
      - python3-jinja2
      - python3-llfuse
      - python3-lxml
      - python3-pil
      - python3-openpyxl
      - python3-progressbar
      - python3-q
      - python3-requests
      - python3-venv
      - python3-xlrd
      - python3-yaml
{% endif %}
      # Bindings
      - swig

# UI

ptpython:
  pip.installed:
    - require:
      - pkg: python_pkgs
