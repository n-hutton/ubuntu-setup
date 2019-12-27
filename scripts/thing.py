#!/usr/bin/env python3

import ipdb
import argparse
import sys
import subprocess
import os

def parse_commandline():
    parser = argparse.ArgumentParser()
    #parser.add_argument('host', help='The host name to perform the checks on')
    #parser.add_argument('-p', '--port', default=8000, type=int, help='The port number to connect to')
    parser.add_argument('args', metavar='N', type=str, nargs='+', help='xxx')
    return parser.parse_args()

def main():
    args = parse_commandline()

    cmd = ["rg", "-i", *args.args]
    #cmd = ["cat", "rg_output_catme.txt"]
    cwd = os.getcwd()

    with open("rg_output.txt", 'w') as logfile:

        print(cmd)
        print("Cwd is " + cwd)

        #import ipdb; ipdb.set_trace(context=20)

        try:
            process = subprocess.Popen(cmd, cwd=cwd, stdout=logfile, stderr=logfile)
            print("here")
            time.sleep(2)
            print("hereaa")
            process.terminate()
            print("here also")
        except:
            print("caught some error!")
            sys.exit(1)

    with open("rg_output.txt", 'r') as logfile:
        for line in logfile.readlines():
            print(line, end='')


#    out, err = process.communicate(timeout = 30)
#
#    if err:
#        print(err)
#    else:
#        #import ipdb; ipdb.set_trace(context=20)
#        #print(out)
#        for line in out.decode('ascii').split('\n'):
#            print(line)
#
#    #import ipdb; ipdb.set_trace(context=20)
#
#    #process.wait()

if __name__ == '__main__':
    main()

