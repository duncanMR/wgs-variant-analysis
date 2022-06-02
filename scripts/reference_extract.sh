#!/bin/bash
ref=$(head -n20 $1 | grep -oP '\-\-reference\s+\w+\b')
echo "$1: $ref"
