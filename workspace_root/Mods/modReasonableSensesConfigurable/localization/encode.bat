:: encode strings from csv & move it to content

del *.w3strings

w3strings --encode en.csv --id-space 3377

:: All kinds of double with the generated test script...
del *.ws

rename en.csv.w3strings en.w3strings

copy en.w3strings ar.w3strings
copy en.w3strings br.w3strings
copy en.w3strings cz.w3strings
copy en.w3strings de.w3strings
copy en.w3strings es.w3strings
copy en.w3strings esmx.w3strings
copy en.w3strings fr.w3strings
copy en.w3strings hu.w3strings
copy en.w3strings it.w3strings
copy en.w3strings jp.w3strings
copy en.w3strings kr.w3strings
copy en.w3strings pl.w3strings
copy en.w3strings ru.w3strings
copy en.w3strings zh.w3strings

cd ../
md content
cd ./localization
move /y *.w3strings ../content