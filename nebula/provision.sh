#! /bin/sh

set -e

DIR='/etc/nebula'

mkdir -m 700 -p "$DIR"

(
    cd "$DIR"

    nebula-cert ca -duration '438001h' -name 'ArkanosisNet'

    sign() {
	nebula-cert sign -duration '438000h' -name "$1" -ip "10.27.0.$2/24" -groups "$3"
    }

    sign 'Tantale' 1 'vps'
    sign 'Bismuth' 2 'vps'
    sign 'taz' 12 'laptop'
    sign 'Edelweiss' 13 'desktop'
    sign 'Cyclamen' 14 'desktop'
    sign 'marvin' 16 'laptop'
    sign 'Bruyere' 18
    sign 'gossamer' 19 'laptop'
    sign 'Amaryllis' 20 'desktop'
    sign 'Mimosa' 28 'desktop'
    sign 'One' 31 'smartphone'
    sign 'Two' 32 'smartphone'
    sign 'Serval' 40
)
