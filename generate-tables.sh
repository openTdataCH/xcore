#!/bin/bash
# Generate the documentation tables as docs/generated/OJP.html from the .xsd schema files
#
# You need the binary `java`

# The -e flag causes the script to exit as soon as one command returns a non-zero exit code
set -e

base_dir="$(dirname "${0}")/.."
xsl_dir=$base_dir/docs
generated_dir="${base_dir}/docs/generated"
basex="/tmp/basex.jar"

echo "Download BaseX ..."

if [ ! -e ${basex} ]; then
	wget --output-document=${basex} https://files.basex.org/releases/10.6/BaseX106.jar
fi

echo "Generating documentation tables ..."

# prepare generated_dir
mkdir -p "${generated_dir}"
rm -f "${generated_dir}"/contab/*.html
java -cp /tmp/basex.jar org.basex.BaseX -b report=contab -b dir=${base_dir} -b odir=${generated_dir} -b custom=${xsl_dir}/custom-ojp.xml -b dnamesExcluded=".git .github" xcore.xq
rm -fr "${generated_dir}"/edesc

echo -e '\033[0;32mFinished generating documentation tables\033[0m'
