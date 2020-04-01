#!/bin/sh

sudo ln -s $(pwd)/main.rb /usr/local/bin/aws-sts-mfa
cp --no-clobber config.yml.sample config.yml
