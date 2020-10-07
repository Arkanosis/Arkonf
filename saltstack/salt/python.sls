# TODO fake-factory (faker)

# VM

python_pkgs:
  pkg.installed:
    - pkgs:
      # VM
      - python
{% if grains['os_family'] == 'Arch' %}
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
      - cython3
      - python-dev
      # Installer
      - python-pip
      - python3-pip
      # Debugger
      - python-pudb
      - python3-pudb
      # Modules
      - python3-click
      - python3-jinja2
      - python3-llfuse
      - python-lxml
      - python-pil
      - python3-openpyxl
      - python-progressbar
      - python3-progressbar
      - python-q # TODO FIXME need it for ArchLinux as well
      - python3-q
      - python-requests
      - python3-venv
      - python-xlrd
      - python3-yaml
{% endif %}
      # Bindings
      - swig

# UI

ptpython:
  pip.installed:
    - require:
      - pkg: python_pkgs
