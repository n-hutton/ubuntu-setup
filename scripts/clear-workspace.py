#!/usr/bin/env python3
import os
import fnmatch

for path in fnmatch.filter(os.listdir('.'), '*.db'):
	print('Removing:', path)
	os.remove(path)
