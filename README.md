# Server Status Telegram Bot

This Bash script monitors the availability of a server by checking the status of a specified port. It utilizes the Telegram bot API to send informative messages to a designated channel regarding the server's status changes.

## Features

- Monitors server availability by checking a specified port (port 2222 in this example).
- Utilizes the Telegram bot API to send notifications about status changes.
- Alerts are sent when the server goes down or comes back up.
- Provides information about downtime and uptime durations.

## Requirements

- Bash
- `curl` command-line tool

## Setup

1. Obtain a Telegram bot token from [BotFather](https://core.telegram.org/bots#botfather).
2. Create a Telegram channel or group and obtain its ID.
3. Replace the `BOT_TOKEN` and `CHANNEL_ID` in the script with your bot token and channel ID respectively.

## Usage

1. Make the script executable: `chmod +x server_status_telegram_bot.sh`
2. Run the script: `./server_status_telegram_bot.sh`

The script will continuously monitor the specified port and send Telegram messages to the designated channel whenever the server's status changes.

## Customization

You can customize the script to monitor a different port or adjust the notification intervals by modifying the `PORT` and `sleep` values in the script.

