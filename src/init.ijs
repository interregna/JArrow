NB. init
cocurrent 'parrow'

lib =: >@((3&{.)@(TAB&cut)&.>)@(LF&cut)
ret =: 0&{::
ptr =: <@(0&{::)

setString=:{{
l1 =. >:@# string =. , > y
string memw (] stringPt =. mema l1),0,l1,2
<stringPt
}}

setInts=:{{
l =. (# , y)
(,y) memw (] Pt =. mema l * 2^2+IF64),0,l,4
<Pt
}}

getString=:{{memr (> y),0,_1,2}}
getStringFree =: {{res [ memf y [ res=.memr (y=.>y),0,_1,2}}
getInts=:{{memr (> y),0,x,4}}

libload =: {{
  if.     UNAME-:'Linux' do.
    arrow    =. '/usr/lib/x86_64-linux-gnu/libarrow-glib.so'
    parquet  =. '/usr/lib/x86_64-linux-gnu/libparquet-glib.so'
    flight   =. '/usr/lib/x86_64-linux-gnu/libarrow-flight-glib.so'
    dataset  =. '/usr/lib/x86_64-linux-gnu/libarrow-dataset-glib.so'
  elseif. UNAME-:'Darwin' do.
    arrow    =.  '/usr/local/lib/libarrow-glib.dylib'
    parquet  =.  '/usr/local/lib/libparquet-glib.dylib'
    flight   =. '/usr/local/lib/libarrow-flight-glib.dylib'
    dataset   =. '/usr/local/lib/libarrow-dataset-glib.dylib'
  elseif. UNAME-:'Win' do.
    arrow    =. 'C:/msys64/mingw64/bin/libarrow-glib-1500.dll'
    parquet  =. 'C:/msys64/mingw64/bin/libparquet-glib-1500.dll'
    flight   =. 'C:/msys64/mingw64/bin/libarrow-flight-glib-1500.dll'
    dataset  =. 'C:/msys64/mingw64/bin/libarrow-dataset-glib-1500.dll'
  end.
  binariesinstalled =. fexist@> arrow;parquet;flight
  msg =. 'Need to install or update binaries.',LF,'See: https://arrow.apache.org/install/',LF,'Missing files:',LF,  LF joinstring ( (-. binariesinstalled) # arrow;parquet;flight)
  msg assert <./ binariesinstalled
  'libArrow libParquet libFlight'  =: dquote each arrow;parquet;flight NB. Add double-quotes for cd calls.
  1
}}

NB. ----- leaf-flag detection ----------------------------------------
NB. The '^' modifier in 15!:0 is a fix-128-14-bugs branch extension
NB. (jsrc/x15.c, commit d2c41121).  Stock J 9.5/9.7 throws DEDEC when
NB. it sees '^' in the type string.  We probe at load time by calling
NB. a known leaf libc function (getpid / GetCurrentProcessId) with the
NB. flag; on stock J the parse fails and we fall back to no-flag.
NB. All Arrow GLib / Parquet GLib / Arrow Flight functions are leaf —
NB. they never invoke registered J callbacks via JDo — so the flag is
NB. semantically safe whenever it parses.
detect_leaf_flag =: 3 : 0
  if.     UNAME -: 'Darwin'  do. lib =. '/usr/lib/libSystem.B.dylib'
  elseif. UNAME -: 'Linux'   do. lib =. 'libc.so.6'
  elseif. UNAME -: 'Win'     do. lib =. 'kernel32.dll'
  elseif. 1                  do. lib =. 'libc.so'
  end.
  fname =. (UNAME -: 'Win') {:: 'getpid';'GetCurrentProcessId'
  ((lib,' ',fname,' > ^ i') & (15!:0)) :: _1: ''
)
LEAFOK =: 0 < detect_leaf_flag ''
LFLAG =: LEAFOK # '^ '   NB. either '^ ' (patched J) or '' (stock J)

cbind =: 4 : 0"1 1
  'type name args' =. y
  v =. (x,' ',name,' ',LFLAG,type)&cd
  (". 'name') =: v
  1
)

init =: {{
  libload''
  r=. 1
  r =. r <. <./ libArrow cbind gLibBindings
  r =. r <. <./ libArrow cbind tableBindings, recordBatchBindings, chunkedArrayBindings
  r =. r <. <./ libArrow cbind basicDatatypeBindings, compositeDataTypeBindings
  r =. r <. <./ libArrow cbind basicArrayBindings, compositeArrayBindings
  r =. r <. <./ libArrow cbind schemaBindings, fieldBindings
  r =. r <. <./ libArrow cbind bufferBindings, codecBindings
  r =. r <. <./ libArrow cbind memoryBindings
  r =. r <. <./ libArrow cbind ipcOptionsBindings,readerBindings,writerBindings
  r =. r <. <./ libArrow cbind fileSystemBindings, localFileSystemBindings
  r =. r <. <./ libArrow cbind readableBindings, inputStreamBindings, writeableBindings, writeableFileBindings, outputStreamBindings, fileBindings
  r =. r <. <./ libParquet cbind parquetReaderBindings, parquetWriterBindings
  r =. r <. <./ libFlight cbind commonFlightBindings, clientFlightBindings, serverFlightBindings
  r
}}
