#!/usr/bin/expect -f
# 7/22/26 kh unblock btantenna, launch bluetoothctl, select default antenna controller by mac, scan and wait for a new pairable device, pair & connect to it to send audio
# Watch for '[NEW] Device 65:7B:D2:52:C5:72 65-7B-D2-52-C5-72'
export btantenna_id=2;
export timeout=10;
export btantenna_mac="04:7F:1E:00:8A:DE";

rfkill unblock $btantenna_id;
set timeout $timeout
spawn bluetoothctl
send "select ${btantenna_mac}\r"
send "scan on\r"
expect -nocase -re "[NEW] Device \w+:\w+:\w+:\w+:\w+:\w+" {
    set mac $expect_out(1,string)
    send "pair $mac\r"
    send "connect $mac\r"
}
expect "Connection successful" {
    send "quit\r"
}
expect eof

