#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

if [ $USERID -ne 0 ]; then
    echo " $TIMESTAMP Please run this script with root access"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo " $TIMESTAMP [ERROR] $2 is..... FAILURE"
    else
        echo " $TIMESTAMP [INFO] $2 is..... SUCCESS"
    fi
}
cp mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "Adding Mongo repo"

dnf install mongodb-org -y 
VALIDATE $? "Installing mongo"