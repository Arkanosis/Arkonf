document_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - bat
{% endif %}
      - calibre
      - ruby-ronn
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

document_pkgs_removed: # https://github.com/saltstack/salt/issues/35592
  pkg.removed:
    - pkgs:
      - nano
