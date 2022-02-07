NB. Install apache-arrow-glib
NB. https://arrow.apache.org/install/

NB. Reads content of all files in .jproj as a string
NB. That string can be written into a single file to 
NB. avoid relative path references
NB. readsource_jp_ 'JPackageDev/arrow'

NB. Writes content of all files in .jproj into a single file. 
NB. Reads all files listed in .jproj
NB. writesourcex_jp_ 'JPackageDev/arrow';'~addons/data/arrow/arrow.ijs' 

require 'project'
loc_z_=: 3 : 'jpath > (4!:4 <''y'') { 4!:3 $0'  NB. pathname of script calling it
ProjPath=: fpath_j_ loc ''

Proj_Src=: ProjPath
Proj_Tgt=: ProjPath,'/arrow.ijs'
writesource_jp_ Proj_Src;Proj_Tgt

echo 'Built file: ',Proj_Tgt
echo 'From: ',Proj_Src
