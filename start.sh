#!/bin/bash

# Start go-cqhttp in the background
cd /cqdata
/app/go-cqhttp faststart & 

sleep 15 

# Check if it's the first run
if [ ! -f "/cqdata/first_run_done" ]; then
  # Run the setup or any other first-time tasks here
  # For example, you can run: python setup.py

  # Mark that the first run has been completed
  touch /cqdata/first_run_done
fi

# Start haruka-bot
cd /haruka_bot
hb run
