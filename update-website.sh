#!/usr/bin/env bash

COM_DIR="gzachos-com"
if ! git clone https://github.com/gzachos/gzachos.github.io/ ${COM_DIR}; then
	exit 1
fi

git rm -rf images
cp -r ${COM_DIR}/images/ .
git add images

for f in *.html
do
	echo "Processing: ${f}"
	cp -f "${COM_DIR}/${f}" .
	sed -i -e $'21 a\\\t\t<link rel="canonical" href="https://gzachos.com/'${f}'" />' ${f}
	sed -i -e 's/shared-files/https:\/\/gzachos.com\/shared-files/g' ${f}
	git add ${f}
done

date > latest-update.txt
git add latest-update.txt

rm -rf ${COM_DIR}
