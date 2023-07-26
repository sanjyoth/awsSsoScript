# awsSsoScript
Script to pull aws credentails

**About**
This page describes the steps to have a script automate the updating process of copying aws access, keys and tokens locally.

**Pre-requisites**
Install aws-sso-creds from here: https://github.com/jaxxstorm/aws-sso-creds
script is supported only for mac at present
install aws toolkit in intellij
create a directory under: </Users/<your_user_name>/.aws
create 2 files - credentials and config
usually we put all secrets within credentials and configurations within config file.

**Steps**
1. Setup the aws sso from the okta command line

2. run "aws sso login" from terminal

3. check you are able to get the creds via running "aws-sso-creds get" and we get output as shown below
 
 aws-sso-creds get
 
  Your temporary credentials for account xxx are:
  
  AWS_ACCESS_KEY_ID xxx
  
  AWS_SECRET_ACCESS_KEY xxx
  
  AWS_SESSION_TOKEN xxx
  
  These credentials will expire at: 2023-03-17 01:52:07 +0530 IST

4. Run "./localScript.sh"

Description of script

"aws-sso-creds get |sed 's/\t/=/g' > /tmp/file1"  — aws-sso-creds would get the access, secret access and token details from aws ssh files. We then convert all tab space characters into equals

"awk -F= -v OFS='=' '/=/{$1=tolower($1)}1' /tmp/file1 > /tmp/file2" ----- We then convert all uppercase characters before equals symbol into lowercase

"sed '1d; $d' /tmp/file2 > /tmp/file1" ----- We then remove the first and last lines which are not needed

"sed -i "" '1s/^/[default]/' /tmp/file1" ----- We then add [default] string at first line

"cat /tmp/file1 > ~/.aws/credentials" ----- We the put the final output into .aws/credentials file

crontab is purely optional and at present above it shows how to add it into your crontab to run every day at 2pm

Once the script runs we expect the intellij should pickup the default profile and able to execute any aws related service calls without issues.

Issues
If we hit session token invalid error then there is a high chance that aws sso login needs to be re-run again
