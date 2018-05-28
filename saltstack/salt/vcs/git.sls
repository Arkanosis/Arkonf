git_pkgs:
  pkg.installed:
    - pkgs:
      - git
      - git-lfs
      - git-review
{% if grains['os_family'] != 'Arch' %}
      - git-svn
{% endif %}
      - tig
