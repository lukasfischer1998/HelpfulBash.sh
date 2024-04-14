#!/bin/bash

LOG_FILE="PATH"
tail -n0 -f /var/log/auth.log | grep -E "session opened|session closed|session opened for user" >> "$LOG_FILE"
