import sys
import os
import ConfigParser
### Reading required vars from config
config = ConfigParser.ConfigParser()
cwd = os.getcwd()
#print("cwd",cwd)
confpath=cwd+"/DevKit/Etc/config.properties"
config.read(confpath)
tenantIDIP = config.get("myvars", "tenantIDIP")
root_path = config.get("myvars", "root_path")
port = config.get("myvars", "port")
#print("root_path",root_path)

if sys.argv[1]=="Register" :
	pypath=cwd+"/DevKit/Thirdparty/Python/bin/python " 
	command= pypath+root_path+"/DevKit/Bin/Services/Server.py "+" "+sys.argv[1]+" "+sys.argv[2]+" "+sys.argv[3]
	#command= "python " +root_path+"/DevKit/Bin/Services/Server.py "+" "+sys.argv[1]+" "+sys.argv[2]+" "+sys.argv[3]
	os.system(command)

if sys.argv[1]=="Predict" :
	pypath=cwd+"/DevKit/Thirdparty/Python/bin/python " 
	command=pypath+root_path+"/DevKit/Bin/Services/Client.py"
	#command= "python " +root_path+"/DevKit/Bin/Services/Client.py"
	os.system(command)

if sys.argv[1]=="setModelConstrut" :
	pypath=cwd+"/DevKit/Thirdparty/Python/bin/python " 
	command= pypath+root_path+"/DevKit/Bin/Services/Server.py "+" "+sys.argv[1]+" "+sys.argv[2]+" "+sys.argv[3]+" "+sys.argv[4]
	#command= "python " +root_path+"/DevKit/Bin/Services/Server.py "+" "+sys.argv[1]+" "+sys.argv[2]+" "+sys.argv[3]+" "+sys.argv[4]
	os.system(command)

if sys.argv[1]=="setDataTranslationXML" :
	pypath=cwd+"/DevKit/Thirdparty/Python/bin/python " 
	command=pypath+root_path+"/DevKit/Bin/Services/Server.py "+" "+sys.argv[1]+" "+sys.argv[2]+" "+sys.argv[3]+" "+sys.argv[4]
	#command= "python " +root_path+"/DevKit/Bin/Services/Server.py "+" "+sys.argv[1]+" "+sys.argv[2]+" "+sys.argv[3]+" "+sys.argv[4]
	os.system(command)

if sys.argv[1]=="setDataOutputXML" :
	pypath=cwd+"/DevKit/Thirdparty/Python/bin/python " 
	command= pypath+root_path+"/DevKit/Bin/Services/Server.py "+" "+sys.argv[1]+" "+sys.argv[2]+" "+sys.argv[3]+" "+sys.argv[4]
	#command= "python " +root_path+"/DevKit/Bin/Services/Server.py "+" "+sys.argv[1]+" "+sys.argv[2]+" "+sys.argv[3]+" "+sys.argv[4]
	os.system(command)


if sys.argv[1]=="schedule" :
	pypath=cwd+"/DevKit/Thirdparty/Python/bin/python " 
	command=pypath+root_path+"/DevKit/Bin/Services/Schedule.py "+" "+sys.argv[1]+" "+sys.argv[2]+" "+sys.argv[3]
	#command= "python " +root_path+"/DevKit/Bin/Services/Schedule.py "+" "+sys.argv[1]+" "+sys.argv[2]+" "+sys.argv[3]
	os.system(command)
