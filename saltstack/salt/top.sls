base:
  '*':
#    - android
#    - apache2
#    - audacity
#    - autoconf
#    - awesome
#    - chromium
#    - darktable
    - emacs
    - etckeeper
#    - ffmpeg
#    - filezilla
    - firefox
#    - g++
#    - gammu
#    - gimp
    - git
#    - gtalk
    - htop
#    - hugin
    - iftop
#    - imagemagick
#    - inkscape
    - iptables
#    - jackd
    - kdiff3
    - keepassx
#    - kipi
#    - knemo
#    - libreoffice
#    - mutt
#    - mysql-server
    - ncdu
#    - ssh
    - p7zip
#    - php
#    - pidgin
    - pwgen
    - python
#    - rawtherapee
#    - remmina
    - rsnapshot
    - urxvt
#    - scribus
#    - sqlite
    - subversion
#    - synergy
#    - sysvbanner
    - tmux
#    - unrar
    - vim
#    - virtualbox
    - vlc
#    - wammu
#    - weechat
#    - whois
#    - wine
#    - wireshark
#    - xpra
#    - yakuake
    - zsh

  'os:(Debian|Ubuntu)':
    - match: grain_pcre
    - aptitude
