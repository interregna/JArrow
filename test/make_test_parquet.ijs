NB. =========================================================
NB. Testing and Development
NB. =========================================================

NB. Creates a python script to make test1.parquet & test2.parquet
NB. Needs python installed with numpy, pandas and pyarrow packages installed
TempPath =. jpath '~temp/'
ppath =: TempPath,'make_test_parquet.py'

ppath fwrite~ ('WD';TempPath) rplc~ 0 : 0
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
'StringCol':pd.array(['This', ' is', 'all', ' valid ', 'text', None, 'data.', ' '], dtype="string"),
'boolCol':np.array([1, 0.5, 0, None, 'a', '', True, False], dtype=bool),
'datetime64Col':np.array(np.arange('2000-01', '2000-01-09', dtype='datetime64[D]')),
}).to_parquet('WD/test2.parquet')
)

echo 'Create parquet file with:'
echo 'python ',ppath
