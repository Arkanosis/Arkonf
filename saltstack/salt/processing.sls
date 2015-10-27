jq:
  pkg:
    - latest

# TODO FIXME from wily only
#python-csvkit:
#  pkg:
#    - latest

# TODO FIXME remove after wily
csvkit:
  pip.installed:
    - require:
      - pkg: python-pip
