#!/usr/bin/env bash

example::ProgressBar()
{
  # Usage: ProgressBar <in:percentage> <in:prefix> <in:sulfix>
  local in_percentage=$1
  local in_prefix="$2"
  local in_sulfix="$3"

  local progress_size=50
  local progress_divisor=$((100/${progress_size}))
  local current_size=$((${in_percentage}/${progress_divisor}))
  # local progress=$(printf '=%.0s' {1..50})
  local progress=""
  for (( index = 0; index <= ${progress_size}; index++ )) ; do
    if (( ${index} >= ${current_size} )) ; then
      progress="${progress} "
    else
      progress="${progress}#"
    fi
  done
  if (( ${in_percentage} >= 100 )) ; then
    echo -ne "${in_prefix}${progress}${in_sulfix} (${in_percentage}%) - DONE\r\n"
  else
    echo -ne "${in_prefix}${progress}${in_sulfix} (${in_percentage}%)\r"
  fi
}

example::EmulateAction()
{
  local total_steps=10
  declare -a actions=("action 01" "action 02" "action 04")
  for action in "${actions[@]}"
  do
    for (( step = 0; step <= $total_steps; step++ )) ; do
      example::ProgressBar $((${step}*10)) " - " " ${action}"
      sleep 1
    done
  done
}

example::EmulateAction
