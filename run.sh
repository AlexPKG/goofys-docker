#!/bin/sh

mkdir -p ~/.aws
cat<<EOF>~/.aws/credentials
[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
EOF

/usr/local/bin/goofys -f --endpoint $S3_URL $OPTION $S3_BUCKET $MNT_POINT
