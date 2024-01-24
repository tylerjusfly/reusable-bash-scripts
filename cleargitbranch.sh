#!/bin/bash


# echo "Contents of the current working directory:"
# ls

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Please install Git and run the script again."
    exit 1
fi

# Check if the "staging" branch exists
if git rev-parse --verify staging &> /dev/null; then
    # Checkout the "staging" branch
    git checkout staging
    echo "Checked out 'staging' branch."
else
    echo "'staging' branch does not exist in the repository."
fi

# Check if there are any local branches (excluding "staging")
branches=$(git branch | grep -v "staging")

if [ -z "$branches" ]; then
    echo "No local branches to remove."
    exit 0
fi

# Confirm with the user before removing branches
read -p "This will remove all local branches except 'staging'. Are you sure? (y/n): " confirm

if [ "$confirm" != "y" ]; then
    echo "Operation aborted."
    exit 0
fi

# Remove local branches (excluding "staging")
echo "$branches" | xargs git branch -D


echo "Local branches (except 'staging') removed successfully."
