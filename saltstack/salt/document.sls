document_pkgs:
  pkg.installed:
    - pkgs:
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
{% endif %}
  pkg.absent:
    - pkgs
       - nano