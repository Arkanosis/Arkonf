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

/home/arkanosis/.gitconfig:
  file.symlink:
    - target: /home/arkanosis/Arkonf/git/.gitconfig
    - user: arkanosis
