NB. ====================
NB. Expose public interface in z locale

transfers=. 0 : 0
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
move transfers