#!/usr/bin/env bash

for f in *.html
do
	echo "Processing: ${f}"
	sed -i -e "22 a \t\t\t<link rel=\"canonical\" href=\"https:\/\/gzachos.com\/${f}\" \/>" ${f}
	sed -i -e 's/shared-files/https:\/\/gzachos.com\/shared-files/g' ${f}
done	

