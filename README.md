# Gotify Push Message
A simple bash script for Linux to send a message to [Gotify](https://gotify.net/) server from CLI.

## Installation
- `cd ~/path`
- `git clone https://github.com/alfiosalanitri/gotify-push-nessage.git`
- `cd gotify-push-message`
- `sudo ./install.sh`

## Dependencies
- curl
- gotify server

## Usage
- `gotify-push -t "Title" -m "Hello World" -p 8 -c markdown -l http://www.alfiosalanitri.it`