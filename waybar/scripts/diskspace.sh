#!/usr/bin/env bash

df -h | grep home | awk '{ print $3"B" "->" $5 }'
