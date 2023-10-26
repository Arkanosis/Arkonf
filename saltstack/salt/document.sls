document_pkgs:
  pkg.installed:
    - pkgs:
      - calibre
      - docx2txt
{% if grains['os_family'] == 'Arch' %}
      - git-delta
{% endif %}
      - kdiff3
{% if grains['os_family'] == 'Arch' %}
      - libreoffice-fresh
      - libreoffice-fresh-fr
      - noto-fonts
      - noto-fonts-cjk
      - noto-fonts-emoji
      - ttf-dejavu
      - zathura-pdf-mupdf
{% else %}
      - fonts-dejavu
      - fonts-noto
      - fonts-noto-cjk
      - fonts-noto-color-emoji
      - libreoffice
{% endif %}
      - odt2txt
      # AUR openboardview-git
      - pdftk
      - ruby-ronn
      - skanlite
      - zathura
      - zathura-djvu
      - zathura-ps
