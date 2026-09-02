#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/roboshop"
sudo mkdir -p $LOGS_FOLDER
sudo chown -R ec2-user:ec2-user $LOGS_FOLDER
sudo chmod -R 755 $LOGS_FOLDER
LOGS_FILE="$LOGS_FOLDER/$0.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

if [ $USERID -ne 0 ]; then
    echo "$TIMESTAMP Please run this script with root access"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo "$TIMESTAMP [ERROR] $2 is..... FAILURE" | tee -a $LOGS_FILE
    else
        echo "$TIMESTAMP [INFO] $2 is..... SUCCESS" | tee -a $LOGS_FILE
    fi
}
cp mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "Adding Mongo repo"

dnf install mongodb-org -y &>> $LOGS_FILE
VALIDATE $? "Installing mongo"