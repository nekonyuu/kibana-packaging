#!/bin/bash
# Downloading master
VERSION=3.0m4
URL=https://github.com/elasticsearch/kibana/archive/v3.0.0milestone4.tar.gz

# Downloading
mkdir -p build usr/share/kibana etc/kibana
cd build
wget ${URL} -O kibana-${VERSION}.tar.gz
tar xf kibana-${VERSION}.tar.gz
cd kibana-*/src/

# Preparing 
cp -r */ index.html ../../../usr/share/kibana/
rm -rf ../../../usr/share/kibana/app/dashboards
cp -r app/dashboards ../../../etc/kibana
cp -r config.js ../../../etc/kibana
cd ../../../
ln -sf /etc/kibana/config.js usr/share/kibana/config.js
ln -sf /etc/kibana/dashboards usr/share/kibana/app/dashboards
cp externals/confs/* etc/kibana

cd ..

fpm -n kibana -v ${VERSION} -a all -C kibana-packaging -m "<jonathan.raffre@smile.fr>" --after-install kibana-packaging/kibana.postinstall --description "Kibana 3 - New Generation Log Analyzer" --url 'http://three.kibana.org/' -t deb --config-files etc/kibana/config.js -d 'apache2 | nginx' -s dir etc usr

