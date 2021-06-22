load '~addons/data/arrow/arrow.ijs'

NB. =========================================================
NB. Testing and Development
NB. =========================================================

NB. test.parquet created in Python:
tempPath =. jpath '~temp/'
ppath =: tempPath,'Jarrow.py'

ppath fwrite~ ('WD';tempPath) rplc~ 0 : 0
import pandas as pd, pyarrow
import numpy as np
pd.DataFrame({'a':list(range(0,8)), 'b':list(range(8,0,-1))}).to_parquet('WD/test1.parquet')
pd.DataFrame(
{'Column 1':list(range(0,8)),
'Column Two':list(np.arange(100, 10, -90/8)),
'shortCol':np.array(np.arange(8), dtype=np.short),
'ushortCol':np.array(np.arange(8), dtype=np.ushort),
'intcCol':np.array(np.arange(8), dtype=np.intc),
'uintcCol':np.array(np.arange(100, 10, -90/8), dtype=np.uintc),
'int_Col':np.array(np.arange(100, 21, -79/8), dtype='int_'),
'uintCol':np.array(np.arange(100, 5, -95/8), dtype='uint'),
'int16Col':np.array(np.arange(300, 10, -290/8), dtype='int16'),
'int32Col':np.array(np.arange(500, 50, -450/8), dtype='int32'),
'int64Col':np.array(np.arange(100, 10, -90/8), dtype='int64'),
'uintCol':np.array(np.arange(100, 10, -90/8), dtype=np.uint),
'longlongCol':np.array(np.arange(100, 10, -90/8), dtype=np.longlong),
'ulonglongCol':np.array(np.arange(100, 10, -90/8), dtype=np.ulonglong),
'DoubleCol':np.array(np.arange(100, 10, -90/8), dtype=np.double),
'StringCol':pd.array(['This', ' is', 'all', ' valid ', 'text', None, 'data.', ''], dtype="string"),
'boolCol':np.array([1, 0.5, 0, None, 'a', '', True, False], dtype=bool),
}).to_parquet('WD/test2.parquet')
)

echo 'Create parquet file with:'
echo 'python ',ppath

NB. Types that exist but are not set up:
NB. 'int8Col':np.array(np.arange(200, 10, -190/8), dtype='int8'),
NB. 'byteCol':np.array(np.arange(100, 10, -90/8), dtype=np.byte),
NB. 'ubyteCol':np.array(np.arange(100, 10, -90/8), dtype=np.ubyte),

NB. Does not exist:
NB. 'csingleCol':np.array(np.arange(8), dtype=np.csingle),
NB. 'cdoubleCol':np.array(np.arange(8), dtype=np.cdouble),
NB. 'clongdoubleCol':np.array(np.arange(8), dtype=np.clongdouble),
NB. 'float16Col':np.array(np.arange(8), dtype=np.float16),
NB. 'float128Col':np.array(np.arange(8), dtype=np.float128),
NB. 'halfCol':np.array(np.arange(8)  , dtype=np.half),