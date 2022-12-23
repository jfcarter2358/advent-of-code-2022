#!/usr/bin/env bash

sum=0
max1=0
max2=0
max3=0
while read -r line; do 
	if [[ "${#line}" == "0" ]]; then
		echo "Comparing sum ${sum} to max ${max}"
		if (( sum > max1 )); then
			echo "sum is greater than max1, setting max1 to ${sum}"
			max3=${max2}
			max2=${max1}
			max1=${sum}
		elif (( sum > max2 )); then
			echo "sum is greater than max2, setting max2 to ${sum}"
			max3=${max2}
			max2=${sum}
		elif (( sum > max3 )); then
			echo "sum is greater than max3, setting max3 to ${sum}"
			max3=${sum}		
		fi
		sum=0
	else
		sum=$((sum + line))
	fi
done < input.txt

echo "Max 1: ${max1}"
echo "Max 2: ${max2}"
echo "Max 3: ${max3}"

total=$((max1 + max2 + max3))
echo "Total: ${total}"
