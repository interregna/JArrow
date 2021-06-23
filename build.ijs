NB. Install apache-arrow-glib
NB. https://arrow.apache.org/install/

NB. Reads content of all files in .jproj as a string
NB. That string can be written into a single file to 
NB. avoid relative path references
NB. readsource_jp_ 'JPackageDev/arrow'

NB. Writes content of all files in .jproj into a single file. 
NB. Reads all files listed in .jproj
writesourcex_jp_ 'JPackageDev/arrow';'~addons/data/arrow/arrow.ijs' 

