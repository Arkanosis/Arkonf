# VM

python:
  pkg:
    - latest

python-dev:
  pkg:
    - latest

# Startup configuration

/home/arkanosis/.pythonrc.py:
  file.symlink:
    - target: /home/arkanosis/Arkonf/python/.pythonrc.py
    - user: arkanosis

/home/arkanosis/local/lib/python2.7/usercustomize.py:
  file.symlink:
    - target: /home/arkanosis/Arkonf/python/usercustomize.py
    - user: arkanosis

# Installer

python-pip:
  pkg:
    - latest

python3-pip:
  pkg:
    - latest

# Debugger

python-pudb:
  pkg:
    - latest

python3-pudb:
  pkg:
    - latest

# Bindings
swig:
  pkg:
    - latest

# Modules

python3-click-cli:
  pkg:
    - latest

python-imaging:
  pkg:
    - latest

python3-jinja2:
  pkg:
    - latest

python-lxml:
  pkg:
    - latest

python-q:
  pkg:
    - latest

python3-q:
  pkg:
    - latest

python-requests:
  pkg:
    - latest

python-xlrd:
  pkg:
    - latest

python3-yaml:
  pkg:
    - latest
