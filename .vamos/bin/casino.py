"""
casino: simple Python script to print random numbers 0 <= n <= 36
"""

import numpy as np
import sys

def random():
    red = [32,4,2,17,6,13,11,8,10,24,33,20,31,22,29,28,35,26]
    number = np.random.randint(37)

    if number == 0:
        print("\x1b[32mgreen:",number,"\x1b[0m")
    elif number in red:
        print("\x1b[31mred:",number,"\x1b[0m")
    else:
        print("black:",number)

if __name__ == '__main__':
    if len(sys.argv) == 0:
        random()
    else:
        print('usage: casino         # get random number (0 <= n <= 36)')
        print('       casino -?      # show help')
        print('       casino --help  # show help')
