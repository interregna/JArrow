loc_z_=: 3 : 'jpath > (4!:4 <''y'') { 4!:3 $0'  NB. pathname of script calling it
ProjPath=: fpath_j_ loc ''                      NB. folder path

NB. =========================================================
NB. Build & Test
NB. =========================================================
load ProjPath,'/build.ijs'   NB. rebuild
load ProjPath,'/arrow.ijs'   NB. reload
NB. run tests here
echo 'Running tests...'
load ProjPath,'/test/test1.ijs'

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
