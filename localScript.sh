#!/bin/sh
echo "Getting creds.."
aws-sso-creds get |sed 's/\t/=/g' > /tmp/file1
awk -F= -v OFS='=' '/=/{$1=tolower($1)}1' /tmp/file1 > /tmp/file2
sed '1d; $d' /tmp/file2 > /tmp/file1
sed -i "" '1s/^/[default]/' /tmp/file1
cat /tmp/file1 > ~/.aws/credentials
echo "aws creds updated.."
rm -rf /tmp/file1
rm -rf /tmp/file2
echo "tmp files cleaned up.."
#(crontab -l 2>/dev/null; echo "* 17 * * * ~/localScript.sh") | crontab -
#echo "Added crontab list.."
