base:
  '*':
    - repos

    - compression
    - crypto
    - database
    - editor
    - etckeeper
    - fs
    - mail
    - monitoring
    - processing
    - python
    - search
    - shell
    - space
    - ssh
    - users
    - utilities
    - vcs

  'G@virtual:physical and G@touchpad:true':
    - touchpad

  'G@virtual:physical and G@productname:NUC*':
    - intel_wifi

  'G@virtual:physical and G@gpus:vendor:intel':
    - intel_gpu

  'G@virtual:physical and G@cpu_model:*Intel*':
    - intel_cpu

  'G@os_family:Arch':
    - awesome
    - pacman

  'I@roles:graphical':
    - audio
    - backup
    - communication
    - document
    - image
    - language
    - media
    - network # TODO some stuff should be in base
    - nginx # TODO some stuff should also be in server
    - pass
    - publication
    - term
    - usb
    - vm
    - webbrowser
    - xorg

  'I@roles:development':
    - android
    - compile
    - java
    - profiling
    - qt

  'I@roles:gaming':
    - gaming

  'I@roles:server':
    - security
    - server # TODO should be mutualized with other states
