NB. init

lib =: >@((3&{.)@(TAB&cut)&.>)@(LF&cut)
ret =: 0&{::
ptr =: <@(0&{::)
getChar =: {{memr (>y),0,_1}}

libload =: 3 : 0
if. UNAME-:'Linux' do.
  libParquet=: '/lib/x86_64-linux-gnu/libparquet-glib.so'
  libArrow=: '/lib/x86_64-linux-gnu/libarrow-glib.so'
elseif. UNAME-:'Darwin' do.
  libParquet =: '"','" ',~  '/usr/local/lib/libparquet-glib.dylib'
  libArrow   =: '"','" ',~  '/usr/local/lib/libarrow-glib.dylib'
elseif. UNAME-:'Win' do.
  libParquet =: '"','" ',~  'C:/msys64/mingqw64/bin/libparquet-glib-400.dll'
  libArrow   =: '"','" ',~  'C:/msys64/mingqw64/bin/libarrow-glib-400.dll'
end.
1
)

cbind =: 3 : 0"1
'type name args' =. y
v =. (libParquet,' ',name,' ',type)&cd
(". 'name') =: v
1
)

init =: 3 : 0

libload''

>./ cbind parquetReaderBindings, parquetWriterBindings
>./ cbind tableBindings, recordBatchBindings, chunkedArrayBindings
>./ cbind basicArrayBindings, compositeArrayBindings
>./ cbind schemaBindings, fieldBindings
>./ cbind basicDatatypeBindings, compositeDataTypeBindings
>./ cbind basicArrayBindings,compositeArrayBindings
>./ cbind bufferBindings

1
)