#!/bin/bash

# This is the script to create EC2 instances

set -euo pipefail # used as advanced error handling flag

check_awscli() {
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

    echo "AWS CLI Installation Completed"
}

configure_aws() {
    local aws_access_key="$AWS_ACCESS_KEY_ID"
    local aws_secret_key="$AWS_SECRET_ACCESS_KEY"
    local aws_region="$AWS_DEFAULT_REGION"

    # Ensuring the .aws directory exists
    mkdir -p ~/.aws

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


wait_for_instance() {
    local instance_id="$1"
    echo "Waiting for instance $instance_id to be in running state..."

    while true; do
	state=$(aws ec2 describe-instances --instance-ids "$instance_id" --query 'Reservations[0].Instances[0].State.Name' --output text)
	if [[ "$state" == "running" ]]; then
	    echo "Instance $instance_id is now running."
	    break
	fi
	sleep 10
    done
}

create_ec2_instance() {
    local ami_id="$1"
    local instance_type="$2"
    local key_name="$3"
    local subnet_id="$4"
    local security_group_ids="$5"
    local instance_name="$6"

    # Run AWS CLI command to create EC2 instance
    instance_id=$(aws ec2 run-instances \
	--image-id "$ami_id" \
	--instance-type "$instance_type" \
	--key-name "$key_name" \
	--subnet-id "$subnet_id" \
	--security-group-ids "$security_group_ids" \
	--tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance_name}]" \
	--query 'Instances[0].InstanceId' \
	--output text
    )

    if [[ -z "$instance_id" ]]; then
	echo "Failed to create EC2 instance." >&2
	exit 1
    fi

    echo "Instance $instance_id created successfully."

    # Wait for the instance to be in running state
    wait_for_instance "$instance_id"
}

main() {

    check_awscli || install_awscli

    configure_aws || {
	echo "AWS Configuration failed, exiting..."
	exit 1
    }

    echo "Creating EC2 instance..."

    # Specify the parameters for creating the EC2 instance
    AMI_ID="ami-04b4f1a9cf54c11d0"
    INSTANCE_TYPE="t2.micro"
    KEY_NAME="$AWS_KEY_NAME"
    SUBNET_ID="$AWS_SUBNET_ID"
    SECURITY_GROUP_IDS="$AWS_SECURITY_GROUP_IDS" # Add your security group IDs seperated by spaces
    INSTANCE_NAME="Shell-Script-EC2-Demo"

    # Call the function to create the EC2 instance
    create_ec2_instance "$AMI_ID" "$INSTANCE_TYPE" "$KEY_NAME" "$SUBNET_ID" "$SECURITY_GROUP_IDS" "$INSTANCE_NAME $SUBNET_ID $SECURITY_GROUP_IDS $INSTANCE_NAME"

    echo "EC2 instance creation completed."
}

main "$@"
