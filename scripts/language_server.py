#!/usr/bin/env python3

import ipdb
import argparse
import sys

def parse_commandline():
    parser = argparse.ArgumentParser()
    #parser.add_argument('host', help='The host name to perform the checks on')
    parser.add_argument('-p', '--port', default=8000, type=int, help='The port number to connect to')
    return parser.parse_args()

def main():
    f = open('/tmp/thingie.txt', 'a')
    f.write("initial ++++")

    for arg in sys.argv:
        f.write(arg)
        print(arg)

    #while True:
    #    recieved = input()
    #    f.write(recieved)


if __name__ == '__main__':
    main()
