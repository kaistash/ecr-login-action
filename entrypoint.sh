#!/usr/bin/env bash
set -e

aws configure <<-EOF
$INPUT_ACCESS_KEY
$INPUT_SECRET_ACCESS_KEY
$INPUT_REGION
text
EOF

connectionString=$(aws ecr get-login --region=us-east-1)
cleanedConnection=$(echo $connectionString | sed -e "s/docker login -u //g" | sed -e "s/ -p//g" | sed -e "s/ -e none//g")
connectionParts=($cleanedConnection)

echo ::set-output name=username::"${connectionParts[0]}"
echo ::add-mask::$USERNAME
echo ::set-output name=password::"${connectionParts[1]}"
echo ::add-mask::$PASSWORD
echo ::set-output name=registry::"${connectionParts[2]}"
echo ::add-mask::$REGISTRY
