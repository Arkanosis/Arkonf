# TODO generate pgp keys

crypto_pkgs:
  pkg.installed:
    - gnupg
{% if grains['os_family'] == 'Arch' %}
    - veracrypt  # TODO FIXME need it for Debian / Kubuntu as well
{% endif %}
