#!/usr/bin/env python

import sys
from lifxlan import LifxLAN, Light

def main ():
    close = Light("d0:73:d5:72:0a:b0", "192.168.1.218")
    close.set_power(1, 0.2)
if __name__=="__main__":
    main()
