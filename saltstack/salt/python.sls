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
      - python2-pip
      # Debugger
      - python-pudb
      - python2-pudb
      # Modules
      - python-click
      - python2-pillow
      - python-jinja
      - python2-lxml
      - python-progressbar
      - python2-progressbar
      - python2-requests
      - python2-xlrd
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
      - python-imaging
      - python3-jinja2
      - python-lxml
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

# Startup configuration

/home/arkanosis/.pythonrc.py:
  file.symlink:
    - target: /home/arkanosis/Arkonf/python/.pythonrc.py
    - user: arkanosis

{% if grains['os_family'] != 'Arch' %}
/home/arkanosis/local/lib/python2.7/usercustomize.py:
  file.symlink:
    - target: /home/arkanosis/Arkonf/python/usercustomize.py
    - user: arkanosis
{% endif %}

# UI

ptpython:
  pip.installed:
    - require:
      - pkg: python_pkgs
