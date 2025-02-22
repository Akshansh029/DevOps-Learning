#!/bin/bash

# This is a script to create S3 bucket using AWS CLI

check_awscli() {

    # Checking if AWS CLI is already installed or not
    if ! command -v aws &> /dev/null; then
        echo "AWS CLI is not installed. Installing it now..." >&2
        return 1
    fi
}

install_awscli() {
    echo "Installing AWS CLI v2 on Linux..."

    # Download and install AWS CLI v2
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    sudo apt-get install -y unzip &> /dev/null
    unzip awscliv2.zip
    sudo ./aws/install

    # Verify installation
    aws --version || {
        echo "AWS CLI installation failed. Please install manually."
        exit 1
    }

    # Clean up
    rm -rf awscliv2.zip ./aws

    echo "AWS CLI Installation Completed."
}

configure_aws() {
    local aws_access_key="$AWS_ACCESS_KEY_ID"
    local aws_secret_key="$AWS_SECRET_ACCESS_KEY"
    local aws_region="$AWS_DEFAULT_REGION"

    # Ensuring the .aws directory exists
    mkdir -p ~/.aws

    # Adding credentials to required files
    cat > ~/.aws/credentials <<EOL
[default]
aws_access_key_id = $aws_access_key
aws_secret_access_key = $aws_secret_key
EOL

    cat > ~/.aws/config <<EOL
[default]
region = $aws_region
output = json
EOL

    echo "AWS CLI configured successfully."
}


create_s3_bucket() {
    echo "Creating S3 bucket with default name as 'shell-scripting-demo'..."
    BUCKET_NAME="shell-scripting-demo"

    aws s3 mb s3://$BUCKET_NAME --region $AWS_DEFAULT_REGION

    if aws s3api head-bucket --bucket "$BUCKET_NAME" 2>/dev/null; then
	echo "S3 bucket created successfully!"
    else
	echo "There was an error creating S3 bucket, exiting the process..."
	exit 1
    fi
}

copy_item_in_bucket() {
    echo "Copying sample item to S3 bucket..."
    local ITEM="/home/vagrant/DevOps-Learning/shell-scripting/script-projects/todo.txt"

    aws s3 cp $ITEM s3://$BUCKET_NAME

    local KEY=$(aws s3api list-objects-v2 --bucket $BUCKET_NAME --query "sort_by(Contents, &LastModified)[-1].Key" --output text)

    if [ -n "$KEY" ]; then
	echo "Item copied successfully! Bucket name: $BUCKET_NAME S3 item Key: $KEY"
    else
	echo "Item couldn't be copied to $BUCKET_NAME bucket"
	return 1
    fi
}

main() {
    check_awscli || install_awscli

    configure_aws || {
        echo "AWS Configuration failed, exiting..."
        exit 1
    }

    create_s3_bucket && copy_item_in_bucket

    echo "********** CREATION OF S3 BUCKET AND COPYING FILE TO BUCKET IS COMPLETED ***********"
}

main
