#!/usr/bin/env bash

COM_DIR="gzachos-com"
if ! git clone https://github.com/gzachos/gzachos.github.io/ ${COM_DIR}; then
	exit 1
fi

# Sync images dir
SRC_DIR="./${COM_DIR}/images"
DST_DIR="./images"
for f in ${SRC_DIR}/*; do
	img_name="$(basename ${f})"
	if ! diff "${SRC_DIR}/${img_name}" "${DST_DIR}/${img_name}" &> /dev/null; then
		echo "Updating ${img_name}..."
		cp -f "./${SRC_DIR}/${img_name}" "${DST_DIR}"
	fi
done

for f in ${DST_DIR}/*; do
	img_name="$(basename ${f})"
	if [ ! -f "${SRC_DIR}/${img_name}" ]; then
		echo "Removing ${img_name}..."
		git rm "${DST_DIR}/${img_name}"
	fi
done

git add ${DST_DIR}

# Sync HTML files
for f in *.html
do
	echo "Processing: ${f}"
	cp -f "${COM_DIR}/${f}" .
	sed -i -e $'21 a\\\t\t<link rel="canonical" href="https://gzachos.com/'${f}'" />' ${f}
	sed -i -e 's/shared-files/https:\/\/gzachos.com\/shared-files/g' ${f}
	git add ${f}
done

# Update latest-update.txt
date > latest-update.txt
git add latest-update.txt

rm -rf ${COM_DIR}
