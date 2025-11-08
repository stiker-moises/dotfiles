#!/usr/bin/env python

import sys
from lifxlan import LifxLAN, Light

def main ():
    bathroom1 = Light("d0:73:d5:6a:2a:41", "192.168.1.43")
    bathroom2 = Light("d0:73:d5:6a:31:e0", "192.168.1.200")
    bathroom3 = Light("d0:73:d5:68:bd:df", "192.168.1.74")
    bathroom1.set_power(1, 0.2)
    bathroom2.set_power(1, 0.2)
    bathroom3.set_power(1, 0.2)
if __name__=="__main__":
    main()
