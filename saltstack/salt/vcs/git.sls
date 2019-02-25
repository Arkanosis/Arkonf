git_pkgs:
  pkg.installed:
    - pkgs:
      - git
{% if grains['oscodename'] != 'stretch' %} # Only available starting with buster
      - git-lfs
{% endif %}
      - git-review
{% if grains['os_family'] != 'Arch' %}
      - git-svn
{% endif %}
      - repo
      - tig
