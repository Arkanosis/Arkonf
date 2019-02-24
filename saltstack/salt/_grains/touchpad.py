import re

touchpad = re.compile('[Tt]ouchpad')

def detect_touchpad():
    with open('/proc/bus/input/devices') as input_devices:
        for line in input_devices:
            if re.search(touchpad, line):
                return { 'touchpad': True }
    return { 'touchpad': False }
