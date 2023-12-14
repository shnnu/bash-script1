#!/bin/bash

AWS_REGION="$2"
INSTANCE_ID="$1"
LOG_FILE="/var/log/output.log"

log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

stop_instances() {
  # Capture the output of stop-instances command and redirect it to the log file
  aws ec2 stop-instances --region "$AWS_REGION" --instance-ids "$INSTANCE_ID" >> "$LOG_FILE" 2>&1

  # Log the instance status
  status=$(aws ec2 describe-instances --region "$AWS_REGION" --instance-ids "$INSTANCE_ID")
  log "Instance $INSTANCE_ID is now $status."
}

stop_instances
   