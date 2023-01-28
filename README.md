# Gotify Push Message
A simple bash script for Linux to send a message to [Gotify](https://gotify.net/) server from CLI.

## Installation
- `cd ~/path`
- `git clone https://github.com/alfiosalanitri/gotify-push-message.git`
- `cd gotify-push-message`
- `./install.sh`

## Dependencies
- curl
- gotify server

## Usage
- `gotify-push -t "Title" -m "Hello World" -p 8 -c markdown -l https://www.alfiosalanitri.it`
