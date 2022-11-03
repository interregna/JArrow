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
    libArrow   =: '/usr/lib/x86_64-linux-gnu/libarrow-glib.so'
    libParquet =: '/usr/lib/x86_64-linux-gnu/libparquet-glib.so'
    libFlight   =: '/usr/lib/x86_64-linux-gnu/libarrow-flight-glib.so'
  elseif. UNAME-:'Darwin' do.
    libArrow   =: '"','" ',~  '/usr/local/lib/libarrow-glib.dylib'
    libParquet =: '"','" ',~  '/usr/local/lib/libparquet-glib.dylib'
    libFlight   =: '"','" ',~  '/usr/local/lib/libarrow-flight-glib.dylib'
  elseif. UNAME-:'Win' do.
    libArrow   =: '"','" ',~  'C:/msys64/mingqw64/bin/libarrow-glib-1000.dll'
    libParquet =: '"','" ',~  'C:/msys64/mingqw64/bin/libparquet-glib-1000.dll'
    libFlight   =: '"','" ',~  'C:/msys64/mingqw64/bin/libarrow-flight-glib-1000.dll'
  end.
  1
}}

cbind =: 4 : 0"1 1
  'type name args' =. y
  v =. (x,' ',name,' ',type)&cd
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
  r =. r <. <./ libArrow cbind bufferBindings
  r =. r <. <./ libArrow cbind memoryBindings
  r =. r <. <./ libArrow cbind ipcOptionsBindings,readerBindings,orcFileReaderBindings,writerBindings
  r =. r <. <./ libArrow cbind fileSystemBindings, localFileSystemBindings
  r =. r <. <./ libArrow cbind readableBindings, inputStreamBindings, writeableBindings, writeableFileBindings, outputStreamBindings, fileBindings
  r =. r <. <./ libParquet cbind parquetReaderBindings, parquetWriterBindings
  r =. r <. <./ libFlight cbind commonFlightBindings, clientFlightBindings, serverFlightBindings
  r
}}
