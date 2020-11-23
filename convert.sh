#!/bin/sh

# file format:
# "kid1": "public_key_base64"
# "kid2": "public_key_base64"
# "kid3": "public_key_base64"

if [ ! -f "/data/file.txt" ]; then
  echo "Usage: docker run -it -v \${PWD}/file.txt:/data/file.txt --rm leandrocarneiro/pem-to-jwks:latest"
  echo ""
  echo "File 'file.txt' in format:"
  echo '"kid1": "public_key_base64"'
  echo '"kid2": "public_key_base64"'
  exit 1
fi

while read r; do 
  K=$(echo $r | cut -d":" -f1| tr -d '"')
  V=$(echo $r | cut -d":" -f2 | tr -d '"')
  echo $V | base64 -d > /tmp/p.key
  /usr/local/bin/pem-jwk /tmp/p.key | jq --arg k "$K" '[ . +{"kid":$k} ]'
done< /data/file.txt | jq 'reduce inputs as $i (.; . += $i)' | jq ' . | {keys: .}' 
