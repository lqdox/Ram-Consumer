#!/bin/bash

arr=()

# Get total RAM in kilobytes
total_mem_kb=$(free -k | awk '/^Mem:/ {print $2}')
# Calculate the size to consume: 0.1% of total RAM
chunk_size_kb=$((total_mem_kb / 500))  # 0.1% of total RAM in kilobytes

echo "Total RAM: $((total_mem_kb / 1024)) MB"
echo "Chunk size to consume per iteration: $chunk_size_kb KB"

while true
do
    # Consume 0.1% of total RAM in each iteration
    arr+=($(head -c $((chunk_size_kb * 1024)) /dev/urandom | base64))
    echo "Consumed $chunk_size_kb KB RAM, continuing..."

    # Get memory info
    total_mem=$(free -m | awk '/^Mem:/ {print $2}')  # Total RAM in MB
    available_mem=$(free -m | awk '/^Mem:/ {print $7}')  # Available RAM in MB
    percent_remaining=$((100 * available_mem / total_mem))  # RAM percentage remaining

    # Display remaining RAM percentage
    echo "RAM Percentage Remaining: $percent_remaining%"

    # Check if remaining RAM is below 10%
    if (( percent_remaining < 10 )); then
        echo "RAM remaining is below 10%. Resetting process..."
        arr=()  # Clear the array to release memory
        echo "Memory reset complete. Continuing process..."
    fi

    sleep 1  # Pause for 1 second before consuming more RAM
done

