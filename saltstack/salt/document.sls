document_pkgs:
  pkg.installed:
    - pkgs:
      - calibre
      - kdiff3
{% if grains['os_family'] == 'Arch' %}
      - libreoffice-fresh
      - libreoffice-fresh-fr
      - noto-fonts
      - noto-fonts-cjk
      - noto-fonts-emoji
      - zathura
      - zathura-djvu
      - zathura-pdf-mupdf
      - zathura-ps
{% else %}
      - libreoffice
      - okular
      - pdftk # TODO FIXME need it for ArchLinux as well
{% endif %}
      - ruby-ronn
