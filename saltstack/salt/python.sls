# TODO fake-factory (faker)

# VM

python_pkgs:
  pkg.installed:
    - pkgs:
      # VM
      - python
{% if grains['os_family'] == 'Arch' %}
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
      - python2-requests
      - python2-xlrd
      - python-yaml
{% else %}
      - python-dev
      # Installer
      - python-pip
      - python3-pip
      # Debugger
      - python-pudb
      - python3-pudb
      # Modules
      - python3-click-cli
      - python-imaging
      - python3-jinja2
      - python-lxml
      - python-q # TODO FIXME need it for ArchLinux as well
      - python3-q
      - python-requests
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

{% if grains['os_family'] != 'Arch' %}
ptpython:
  pip.installed:
    - require:
      - pkg: python_pkgs
{% endif %}
