NB. ====================
NB. Expose public interface in z locale

transfers=. 0 : 0
printTableSchema
readTableNames
readTableSchema
readTableColName

readArrowTable
readArrowsTable
readFileBufferTable
readBufferTable

writeArrowTable
writeArrowsTable
writeFeatherTable
writeParquet

ho
hc
hs
hr
hp
schemaOf

sbo
sbn
sbc

ax
ai
md
mdw

afk
afsum
afmean
afmin
afmax
afcount

wcsv
wjsonl

extreg
extq4
extq8
exte

readParquetSchema
printParquetSchema
readParquetData
readParquetTable
readsParquetTable
readParquetDataframe
readParquetCol

readFeatherSchema
printFeatherSchema
readFeatherData
readFeatherTable
readsFeatherTable
readFeatherDataframe
readFeatherCol

readCSVSchema
printCSVSchema
readCSVData
readCSVTable
readsCSVTable
readCSVDataframe
readCSVCol

readJsonSchema
printJsonSchema
readJsonData
readJsonTable
readsJsonTable
readJsonDataframe
readJsonCol

readFeatherSchema
printFeatherSchema
readFeatherData
readFeatherTable
readsFeatherTable
readFeatherDataframe
readFeatherCol
)

localemover =. ((,&'_parrow_')@[  (],(' =: '&,)@[)   (,&'_z_')@])
move =. (".@localemover@deb each)@(LF&cut) 
1 [ move transfers
