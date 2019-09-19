#!/bin/bash

mkdir -p ./keys
ssh-keygen -t rsa -m PEM -f ./keys/id_rsa_teamcity -N ""
