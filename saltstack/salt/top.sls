base:
  '*':
    - repos

    - compression
    - editor
    - etckeeper
    - mail
    - monitoring
    - search
    - shell
    - space
    - ssh
    - utilities
    - vcs

  'G@virtual:physical and G@touchpad:true':
    - touchpad

  'G@virtual:physical and G@gpus:vendor:intel':
    - intel_gpu

  'G@os_family:Arch':
    - awesome
    - pacman

  'I@roles:graphical':
    - android
    - audio
    - backup
    - banner
    - communication
    - compile
    - crypto
    - database
    - document
    - fs
    - ftp
    - kdiff3
    - image
    - java
    - language
    - media
    - network # TODO some stuff should be in base
    - nginx # TODO some stuff should also be in server
    - pass
    - processing
    - profiling
    - publication
    - python
    - qt
    - term # TODO tmux should be in base
    - usb
    - vm
    - webbrowser
    - xorg

    - users

  'I@roles:server':
    - security
    - server # TODO should be mutualized with other states
