loc_z_=: 3 : 'jpath > (4!:4 <''y'') { 4!:3 $0'  NB. pathname of script calling it
ProjPath=: fpath_j_^:2 loc ''                   NB. path of grand-parent folder (project)
TempPath=: jpath '~temp/'
`
NB. copy test parquet files to ~temp if they're not already there
copytestfiles =. {{
  tstpqs=: <;._2 , 0 dir ProjPath,'/test/test*.',y
  if. -. fexist TempPath&,&.> tstpqs do.
      (TempPath&,&.> tstpqs) fcopynew&> (ProjPath,'/test/')&,&.> tstpqs
  end.
}}

copytestfiles each 'parquet';'csv';'jsonl';'arrow';'json';'feather'

load ProjPath,'/arrow.ijs'
coinsert 'parrow'

t1path =. TempPath,'test1.parquet'

tp1 =. readParquet t1path
echo readTableSchema tp1
echo readData tp1
echo readDataInverted tp1
echo readTable tp1
echo readsTable tp1
echo readDataframe tp1

echo readParquetData t1path
echo readParquetSchema t1path
echo readParquetTable t1path
echo readsParquetTable t1path
echo readParquetDataframe t1path
echo readParquetCol t1path;1

NB. =========================================================
t2path =. TempPath,'test2.parquet'
tp2 =. readParquet t2path
echo readTableSchema tp2
echo readData tp2
echo readDataInverted tp2
echo readTable tp2
echo readsTable tp2
echo readDataframe tp2

echo readParquetSchema t2path
echo readParquetData t2path
echo readParquetTable t2path
echo readsParquetTable t2path
echo readParquetDataframe t2path
echo readParquetCol t2path;14

NB. =========================================================
t3path =. TempPath,'test1.csv'
tp3 =. readCSV t3path
echo readTableSchema tp3
echo readData tp3
echo readDataInverted tp3
echo readTable tp3
echo readsTable tp3
echo readDataframe tp3

echo readCSVSchema t3path
echo readCSVData t3path
echo readCSVTable t3path
echo readsCSVTable t3path
echo readCSVDataframe t3path
echo readCSVCol t3path;0



": < 10
