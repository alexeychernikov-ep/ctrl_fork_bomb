#!/usr/bin/env bash

set -euo pipefail
IFS=$' \n\t'

OLDDIR=$(pwd)
SRCPATH=$(readlink -f "${0}")
WORKDIR=$(dirname "${SRCPATH}")
cd "${WORKDIR}"

count="${1:-UNDEFINED}"
delay="${2:-UNDEFINED}"

if [ "${count}" == "UNDEFINED" -o "${delay}" == "UNDEFINED" ]
then
	echo "Usage: ${0} <n_proc> <delay_in_sec>"
	echo "E.g. ${0} 128 60"

	exit 1
fi

bomb() {
	local old_count="${1:-UNDEFINED}"
	local new_count="$((old_count-1))"

	if [ "${old_count}" == "0" ]
	then
		return 0
	fi

	bomb "${new_count}" &

	sleep "${delay}s"
};

bomb "${count}"
