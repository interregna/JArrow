## Usage
Ultimately:
load'data/arrow'
(This will work if the project has already been opened and built with Ctrl+F9)


## Development
1) In Jqt, set your path for JPackageDev

Example:
File > Configure > Folders
JPackageDev /code/JPackageDev

2) Place the arrow directory in JPackageDev

3) Restart Jqt and open the Arrow project
Project > Open > JPackageDev > arrow

4) Build the addon.
Ctrl + F9

5) Run the addon.
 F9 (if the arrow project is open)
 or
 load'data/arrow' (if the project has already been built with Ctrl+F9)

Examples:
see run.ijs
Create parquet files with Python

```
ppath =. tempPath,'test1.parquet'
tp =. readParquet ppath
echo readSchemaString tp
echo readSchema tp
echo readData tp
echo readTable tp
echo readsTable tp

echo readParquetData ppath
echo readParquetSchema ppath
echo readParquetTable ppath
echo readsParquetTable ppath
echo readParquetColumn ppath;1

NB. =========================================================
ppath2 =. tempPath,'/test2.parquet'
tp2 =. readParquet ppath2
echo readSchemaString tp2
echo readSchema tp2
echo readData tp2
echo readTable tp2
echo readsTable tp2

echo readParquetSchema ppath2
echo readParquetData ppath2
echo readParquetTable ppath2
echo readsParquetTable ppath2
readParquetColumn ppath2;14
```

TODO:
[ ] Figure out how to formalize data/arrow.ijs as an add-on
[ ] install 'github:interregna/JArrow@main' 
	- Looks like a conflicting process
	- Seems to copy the whole repo, thus overwriting data/arrow.ijs