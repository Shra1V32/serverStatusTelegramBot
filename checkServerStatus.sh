#!/bin/bash

# What this script does?
# This script checks for reverse tunneled port, in my case it's 2222
# These ports will be checked under an infinite while loop
# If the port doesn't exist, The current machine will send you the message to the Telegram Channel Instantly
# By Default the accuracy is set as 5 seconds 

# Please enter your Telegram bot token and channel ID below
BOT_TOKEN='' # Your Bot Token which is issued by BotFather 
CHANNEL_ID='' # Prepend -100 to the channel ID
CHECK_PORT='2222' # Which port to check?

# Function to send styled message to Telegram channel
send_telegram_message() {
    local message="$1"
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
         -H "Content-Type: application/json" \
         -d "{\"chat_id\": \"$CHANNEL_ID\", \"text\": \"$message\", \"parse_mode\": \"HTML\", \"disable_notification\": false}"
}

uptime=0
downtime=0
previous_status="up"

while true; do
    # Check if port is open
    nc -z localhost $CHECK_PORT > /dev/null 2>&1
    PORT_STATUS=$?

    if [ $PORT_STATUS -ne 0 ]; then
        if [[ "$previous_status" == "up" ]]; then
            message="<b>⚠️ Server is down! ⚠️</b>\n\nLast Uptime: $((uptime / 60)) minutes\nLast Downtime: $((downtime / 60)) minutes"
            send_telegram_message "$message"
            downtime=0
            previous_status="down"
        fi

        while [ $PORT_STATUS -ne 0 ]; do
            sleep 5  # Wait for 5 second before rechecking
            nc -z localhost 2222 > /dev/null 2>&1
            PORT_STATUS=$?
            downtime=$((downtime + 5))
        done
    else
        if [[ "$previous_status" == "down" ]]; then
            message="<b>✅ Server is up! ✅</b>\n\nLast Downtime: $((downtime / 60)) minutes\nLast Uptime: $((uptime / 60)) minutes"
            send_telegram_message "$message"
            uptime=0
            previous_status="up"
        fi
        uptime=$((uptime + 5))
    fi

    sleep 5  # Wait for 5 second before rechecking
done