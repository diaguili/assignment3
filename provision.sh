#!/bin/bash
# assign variables
ACTION=${1}
version="1.0.0"
function show_version() {
echo $version
}
function uninstall_nginx() {
sudo service nginx stop
sudo aws s3 rm s3://rclc-assignment-3/index.html/usr/share/nginx/html/index.html
yum remove nginx -y 
}
function install_nginx() {
sudo yum update -y 
sudo amazon-linux-extras install nginx1.12 -y 
sudo chkconfig nginx on 
sudo aws s3 cp s3://rclc-assignment-3/index.html/usr/share/nginx/html/index.html 
sudo service nginx start
}
function display_help() {
cat << EOF
Usage: ${0} {-c|--create|-h|--help}
OPTIONS:
    -v | --version  Show version of script
    -d | --delete   Delete a file
    -c | --create   Create a new file
    -h | --help Display the command help
Examples:
    Display version:
        $ ${0} -v
    Delete a file:
        $ ${0} -d foo
    Create a new file:
        $ ${0} -c foo.txt
    Display help:
        $ ${0} -h
EOF
}
case "$ACTION" in
    -h|--help)
        display_help
        ;;
    "")
        install_nginx
        ;;
    -r|--remove)
        uninstall_nginx
        ;;
    -v|--version)
        show_version
        ;;
    *)
    echo "Usage ${0} {-v|-d|-c|-h}"
    exit 1
esac
