document_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - libreoffice-fresh
      - libreoffice-fresh-fr
      - zathura
      - zathura-djvu
      - zathura-pdf-mupdf
      - zathura-ps
{% else %}
      - libreoffice
      - okular
{% endif %}
 