#!/usr/bin/env python

import sys
from lifxlan import LifxLAN, Light

def main ():
    computer1 = Light("d0:73:d5:71:9d:75", "192.168.1.75")
    computer2 = Light("d0:73:d5:6a:fa:56", "192.168.1.113")
    stairs = Light("d0:73:d5:72:0b:74", "192.168.1.230")
    living = Light("d0:73:d5:71:a4:a2", "192.168.1.117")
    computer1.set_power(1, 0.2)
    computer2.set_power(1, 0.2)
    stairs.set_power(1, 0.2)
    living.set_power(1, 0.2)
if __name__=="__main__":
    main()
