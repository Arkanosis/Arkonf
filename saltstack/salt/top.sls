base:
  '*':
    - repos

    - compression
    - editor
    - etckeeper
    - monitoring
    - search
    - shell
    - space
    - ssh
    - utilities
    - vcs

  'G@virtual:physical and G@touchpad':
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
    - chat
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
    - mail # TODO some stuff should be in base
    - media
    - network # TODO some stuff should be in base
    - nginx
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
