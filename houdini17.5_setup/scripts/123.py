import os, sys,inspect
file_path = os.path.realpath(inspect.getfile(inspect.currentframe()))
pydir = os.path.dirname(file_path)  
if  pydir not in sys.path:
	sys.path.append(pydir)

import hrpyc
hrpyc.start_server()

import hou
hou.node("/obj").createNode("geo").setName("Dev")

