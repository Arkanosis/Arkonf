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
      - zathura
      - zathura-djvu
      - zathura-pdf-mupdf
      - zathura-ps
{% else %}
      - libreoffice
      - odt2txt
      - okular
{% endif %}
      - pdftk
      - ruby-ronn
