#!/bin/bash

# Prompt the user for the branch name or accept "staging" as default
read -p "Enter the name of the branch to check out (default: staging): " branch_name
branch_name=${branch_name:-staging}

# Prompt user for branches to ignore
read -p "Enter the name of the branches to ignore.: " ignore_branches 
ignore_branches=${ignore_branches}

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Please install Git and run the script again."
    exit 1
fi

# Check if the specified branch exists
if git rev-parse --verify "$branch_name" &> /dev/null; then
    # Checkout the specified branch
    git checkout "$branch_name"
    echo "Checked out '$branch_name' branch."
else
    echo "'$branch_name' branch does not exist in the repository."
fi

# Check if there are any local branches (excluding the specified branch)
# branches=$(git branch | grep -v "$branch_name")

# Get all local branches
branches=$(git branch)

# Filter out the specified branch and branches in the ignore list
for branch in $ignore_branches; do
  branches=$(echo "$branches" | grep -v "\b$branch\b")
done
# Filter out the checkout branch and branches in the ignore list
# for branch in "$branches"; do
#   if [[ "$branch" == "$ignore_branches" || "$branch" == "$branch_name" ]]; then
#     continue  # Skip checkout branch and branches in the ignore list
#   fi
#   branches=$(echo "$branches" | grep -v "\b$branch\b")
# done

if [ -z "$branches" ]; then
    echo "No local branches to remove."
    exit 0
fi

# Confirm with the user before removing branches
read -p "This will remove all local branches except '$branch_name' and ignore '$ignore_branches'. Are you sure? (y/n): " confirm

if [ "$confirm" != "y" ]; then
    echo "Operation aborted."
    exit 0
fi

# Remove local branches (excluding the specified branch)
echo "$branches" | xargs git branch -D

# echo $ignore_branches

echo "Local branches (except '$branch_name') removed successfully."
