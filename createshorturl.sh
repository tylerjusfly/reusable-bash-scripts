#!/bin/bash

# Function to shorten a URL using is.gd
shorten_url_isgd() {
    local long_url="$1"
    local short_url=$(curl -s "https://is.gd/create.php?format=simple&url=${long_url}")
    echo "$short_url"
}

# Function to shorten a URL using tinyurl.com as a fallback
shorten_url_tinyurl() {
    local long_url="$1"
    local short_url=$(curl -s "https://tinyurl.com/api-create.php?url=${long_url}")
    echo "$short_url"
}

# Main function to handle URL shortening with fallback
shorten_url() {
    local long_url="$1"
    local short_url

    # Try is.gd first
    short_url=$(shorten_url_isgd "$long_url")

    # Check if is.gd was successful (assuming success if "https://" in response)
    if [[ "$short_url" != *"https://"* ]]; then
        echo "is.gd failed, trying TinyURL..."
        short_url=$(shorten_url_tinyurl "$long_url")

        # Check if TinyURL was successful
        if [[ "$short_url" != *"https://"* ]]; then
            echo "Error: Could not shorten URL. Please check the URL or try again later."
            return 1
        fi
    fi

    echo "Shortened URL: $short_url"
}

# Main script execution
# Check if a URL argument was passed
if [[ -z "$1" ]]; then
    echo "Usage: $0 <url-to-shorten>"
    exit 1
fi

# Call the shorten function with the provided URL
shorten_url "$1"
