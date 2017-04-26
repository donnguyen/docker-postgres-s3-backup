#!/bin/bash
set -e

fname="$DBNAME-$(date +%Y%m%d-%H%M%S).sql.gz"
dname="/data/"
rm -rf "$dname"
mkdir -p "$dname"

echo 'BK----------------- Backing up database file...'
/bin/bash backup-db.sh "$dname$fname"
echo 'BK----------------- Backed up'

echo 'BK----------------- Uploading database file to S3...'
/bin/bash s3setup.sh
cd "$dname"
/usr/bin/s3cmd put --rr --progress "$fname" $AWS_S3_PATH$fname
echo 'BK----------------- Uploaded database file to S3'

cd /
rm -rf "$dname"
