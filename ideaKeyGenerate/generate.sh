#!/bin/bash
echo Welcome to http://inhu.net
read -p "Enter your name:" name
echo "-------------------Your key---------------"
java Keygen $name
echo "---------------http://inhu.net------------"
