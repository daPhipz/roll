#!/bin/bash

# Function to roll a single die with a given number of sides
roll_die() {
  sides=$1
  echo $(( RANDOM % sides + 1 ))
}

# Check if at least one argument is provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 2d8 1d20 ..."
  exit 1
fi

# Total sum of all rolls and modifiers
total_sum=0

# Process each argument
for arg in "$@"; do
  if [[ $arg =~ ^([0-9]+)d([0-9]+)$ ]]; then
    # If argument is in the format XdY (e.g., 2d8)
    num_dice=${BASH_REMATCH[1]}
    sides=${BASH_REMATCH[2]}

    # Roll the dice and calculate the sum
    echo -n "$num_dice""d""$sides rolls: "
    sum=0
    for ((i = 1; i <= num_dice; i++)); do
      roll=$(roll_die "$sides")
      echo -n "$roll "
      sum=$((sum + roll))
    done

    echo "(sum: $sum)"
    total_sum=$((total_sum + sum))
  else
    echo "Invalid format: $arg"
  fi
done

# Display the total sum of all rolls and modifiers
echo "Total sum of all rolls and modifiers: $total_sum"
