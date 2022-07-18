loc_z_=: 3 : 'jpath > (4!:4 <''y'') { 4!:3 $0'  NB. pathname of script calling it
ProjPath=: fpath_j_^:2 loc ''                   NB. path of grand-parent folder (project)
TempPath=: jpath '~temp/'

NB. copy test parquet files to ~temp if they're not already there
{{
  tstpqs=: <;._2 , 0 dir ProjPath,'/test/test*.parquet'
  if. -. fexist TempPath&,&.> tstpqs do.
      (TempPath&,&.> tstpqs) fcopynew&> (ProjPath,'/test/')&,&.> tstpqs
  end.
}}''

load ProjPath,'/arrow.ijs'
coinsert 'parrow'

t1path =. TempPath,'test1.parquet'
tp1 =. readParquet t1path
echo readSchemaString tp1
echo readSchema tp1
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
echo readParquetColumn t1path;1

NB. =========================================================
t2path =. TempPath,'/test2.parquet'
tp2 =. readParquet t2path
echo readSchemaString tp2
echo readSchema tp2
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
echo readParquetColumn t2path;14
