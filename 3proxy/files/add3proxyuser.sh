#!/bin/sh

ensure_file_exist() {
	[ -f "$1" ] || touch "$1"
}

if [ $4 ]; then
	PWD_CFG=/etc/3proxy/passwd
	CNT_CFG=/etc/3proxy/counters
	BAND_CFG=/etc/3proxy/bandlimiters

	ensure_file_exist $PWD_CFG
	ensure_file_exist $CNT_CFG
	ensure_file_exist $BAND_CFG
	echo $1:$(/usr/bin/mycrypt $$ $2) >>$PWD_CFG
	echo countin \"$(wc -l $CNT_CFG | awk '{print $1}')/$1\" D $3 $1 >>$CNT_CFG
	echo bandlimin $4 $1 >>$BAND_CFG
else
	echo usage: $0 username password day_limit bandwidth
	echo "	"day_limit - traffic limit in MB per day
	echo "	"bandwidth - bandwith in bits per second 1048576 = 1Mbps
fi
