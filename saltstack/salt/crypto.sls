# TODO generate pgp keys

crypto_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Arch' %}
      - gpg-tui
{% endif %}
      - gnupg
      - openssl
{% if grains['os_family'] != 'Arch' %}
      - pinentry-tty
      - signify-openbsd
{% else %}
      - signify
{% endif %}
{% if grains['os_family'] == 'Arch' %}
      - veracrypt  # TODO FIXME need it for Debian as well, or consider zulucrypt or plain dm-crypt instead
{% endif %}
