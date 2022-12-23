#!/usr/bin/env bash

echo "" > output.txt

total_score=0
char_left_rock="A"
char_left_paper="B"
char_left_scissors="C"
char_right_rock="X"
char_right_paper="Y"
char_right_scissors="Z"
score_rock=1
score_paper=2
score_scissors=3
score_win=6
score_draw=3
score_loss=0

loss_arr=("${char_left_rock}${char_right_scissors}" "${char_left_paper}${char_right_rock}" "${char_left_scissors}${char_right_paper}")
win_arr=("${char_left_rock}${char_right_paper}" "${char_left_paper}${char_right_scissors}" "${char_left_scissors}${char_right_rock}")
draw_arr=("${char_left_rock}${char_right_rock}" "${char_left_paper}${char_right_paper}" "${char_left_scissors}${char_right_scissors}")

function main {
	while read -r line; do 
		local left="${line:0:1}"
		local right="${line:2:1}"
		local score=$(get_score "${left}" "${right}")
		total_score=$((total_score + score))
	done < input.txt

	echo "Score: ${total_score}"
}

function get_hand_score {
	local outcome="$1"
	local right="$2"
	local score=0

	case $outcome in
		draw)
			score=$((score + score_draw))
			;;
		win)
			score=$((score + score_win))
			;;
		loss)
			score=$((score + score_loss))
			;;
		*)
			echo "outcome: ${outcome}" >> output.txt
			;;
	esac

	case $right in
		$char_right_rock)
			score=$((score + score_rock))
			;;
		$char_right_paper)
			score=$((score + score_paper))
			;;
		$char_right_scissors)
			score=$((score + score_scissors))
			;;
		*)
			echo "right: ${right}" >> output.txt 
			;;
	esac

	echo "${score}"
}

function get_score {
	local left=$1
	local right=$2
	echo "${left}:${right}" >> output.txt
	for play in "${draw_arr[@]}"; do
		if [[ "${left}${right}" == "${play}" ]]; then
			echo "draw: ${left}${right}" >> output.txt
			echo "$(get_hand_score "draw" "${right}")"
			return
		fi
	done
	for play in "${win_arr[@]}"; do
		if [[ "${left}${right}" == "${play}" ]]; then
			echo "win: ${left}${right}" >> output.txt
			echo "$(get_hand_score "win" "${right}")"
			return
		fi
	done
	for play in "${loss_arr[@]}"; do
		if [[ "${left}${right}" == "${play}" ]]; then
			echo "loss: ${left}${right}" >> output.txt
			echo "$(get_hand_score "loss" "${right}")"
			return
		fi
	done
}

main
