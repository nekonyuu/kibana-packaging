#!/bin/bash
# Downloading master
VERSION=3.0m4
URL=https://github.com/elasticsearch/kibana/archive/v3.0.0milestone4.zip

# Downloading
mkdir -p build usr/share/kibana etc/kibana
cd build
wget ${URL} -O kibana-${VERSION}.tar.gz
tar xf kibana-${VERSION}.tar.gz
cd kibana-master

# Preparing 
cp -r common index.html js panels partials sample vendor ../../usr/share/kibana/
cp -r dashboards config.js ../../etc/kibana
cp dashboards/logstash.json ../../etc/kibana/dashboards/default.json
cd ../../
ln -sf /etc/kibana/config.js usr/share/kibana/config.js
ln -sf /etc/kibana/dashboards usr/share/kibana/dashboards

cd ..

fpm -n kibana -v ${VERSION} -a all -C kibana-packaging -m "<jonathan.raffre@smile.fr>" --after-install kibana-packaging/kibana.postinstall --description "Kibana 3 - New Generation Log Analyzer" --url 'http://three.kibana.org/' -t deb --config-files etc/kibana/config.js -d httpd -s dir etc usr

