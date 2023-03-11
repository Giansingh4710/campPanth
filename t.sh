#!/bin/bash

original_50_pages_unchanged() {
	folderName=original_50_pages_unchanged
	mkdir "$folderName"

	ikea=$(cat ./ikea.txt)
	ikeaLinkInd=1

	for link in $ikea; do
		curl -o "${folderName}/ikea${ikeaLinkInd}.html" "$link"
		ikeaLinkInd=$((ikeaLinkInd + 1))
	done

	bedBath=$(cat ./bedBath.txt)
	bedBathLinkInd=1

	for link in $bedBath; do
		curl -o "${folderName}/bedBath${bedBathLinkInd}.html" "$link"
		bedBathLinkInd=$((bedBathLinkInd + 1))
	done
}

extract_data_from_local_files() {
	path_to_html_file=$1
	path_to_xhtml_file=$2
	store=$3

	java -jar tagsoup-1.2.1.jar --output-encoding=utf-8 --files "$path_to_html_file"
	python3 parser.py "$store" "$path_to_xhtml_file"
	rm "$path_to_xhtml_file"
}

download_and_extract_data() {
	path_to_html_file=$1
	link=$2
	path_to_xhtml_file=$3
	store=$4

	curl -o "$path_to_html_file" "$link"
	java -jar tagsoup-1.2.1.jar --output-encoding=utf-8 --files "$path_to_html_file"
	rm "$path_to_html_file"
	python3 parser.py "$store" "$path_to_xhtml_file"
	rm "$path_to_xhtml_file"
}

if [ ! -f "./tagsoup-1.2.1.jar" ]; then
  curl -O "https://repo1.maven.org/maven2/org/ccil/cowan/tagsoup/tagsoup/1.2.1/tagsoup-1.2.1.jar" #-O to safe file name as original file name
fi

extract_data_from_files "$1" "$2"
java -jar tagsoup-1.2.1.jar --output-encoding=utf-8 --files ./index.html

echo Done
