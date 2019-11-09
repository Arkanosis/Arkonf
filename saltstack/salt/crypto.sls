# TODO generate pgp keys

crypto_pkgs:
  pkg.installed:
    - pkgs:
      - gnupg
      - openssl
{% if grains['os_family'] == 'Arch' %}
      - veracrypt  # TODO FIXME need it for Debian / Kubuntu as well, or consider zulucrypt or plain dm-crypt instead
{% endif %}
