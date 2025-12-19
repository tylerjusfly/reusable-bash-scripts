#!/bin/bash

# ================================
# Multi GitHub Account Switcher
# Author: Tyler
# ================================

# Check if username was passed
if [ -z "$1" ]; then
  echo "Usage: $0 <tyler | sonnul | appnigma>"
  exit 1
fi

ACCOUNT="$1"
GIT_URL="git:https://github.com"

# ----------------
# TOKENS
# ----------------
TYLER_TOKEN="Enter github token here"
SONNUL_TOKEN="Enter github token here"
APPNIGMA_TOKEN="Enter github token here"

# ----------------
# ACCOUNT CONFIGS
# ----------------

if [ "$ACCOUNT" == "tyler" ]; then
  GIT_USER="tylerjusfly"
  GIT_EMAIL="tylerjusfly1@gmail.com"
  GIT_TOKEN="$TYLER_TOKEN"

elif [ "$ACCOUNT" == "sonnul" ]; then
  GIT_USER="tylersonn"
  GIT_EMAIL="tyler@sonnul.com"
  GIT_TOKEN="$SONNUL_TOKEN"

elif [ "$ACCOUNT" == "appnigma" ]; then
  GIT_USER="tylerofnigma"
  GIT_EMAIL="tyler@appnigma.ai"
  GIT_TOKEN="$APPNIGMA_TOKEN"

else
  echo "❌ Invalid account."
  echo "Use: tyler | sonnul | appnigma"
  exit 1
fi

# ----------------
# CLEAR OLD GITHUB CREDENTIALS
# ----------------
cmdkey /delete:$GIT_URL 2>/dev/null

# ----------------
# SET NEW CREDENTIAL
# ----------------
cmdkey /generic:$GIT_URL /user:$GIT_USER /pass:$GIT_TOKEN

# ----------------
# SET GIT AUTHOR IDENTITY (GLOBAL)
# ----------------
git config --global user.name "$GIT_USER"
git config --global user.email "$GIT_EMAIL"

# ----------------
# CONFIRMATION
# ----------------
echo "✅ Switched GitHub authentication to: $GIT_USER"
echo "✅ Switched Git commit identity to:"
echo "   Name : $GIT_USER"
echo "   Email: $GIT_EMAIL"
echo "✅ You are now fully operating as: $ACCOUNT"

