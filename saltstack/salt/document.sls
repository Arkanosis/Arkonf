document_pkgs:
  pkg.installed:
    - pkgs:
      - calibre
{% if grains['os_family'] == 'Arch' %}
      - difftastic
{% endif %}
      - docx2txt
{% if grains['os_family'] == 'Arch' %}
      - git-delta
{% endif %}
{% if grains['host'] in ['Cyclamen', 'Mimosa'] %}
      - hplip
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
{% if grains['host'] in ['Cyclamen', 'Mimosa'] %}
      - skanlite
{% endif %}
      - zathura
      - zathura-djvu
      - zathura-ps

{% if grains['host'] in ['Cyclamen', 'Mimosa'] %}
hp-setup -i -a -x && touch /root/.hp-setup-done:
  cmd.run:
    - unless: test -f /root/.hp-setup-done
{% endif %}
