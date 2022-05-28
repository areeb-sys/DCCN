set ns [new Simulator]
set nf [open o.nam w]
$ns namtrace-all $nf


$ns rtproto DV
#creating nodes

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

#Creating connections

$ns duplex-link $n0 $n1 10Mb 10ms DropTail
$ns duplex-link $n1 $n2 10Mb 10ms DropTail
$ns duplex-link $n2 $n3 10Mb 10ms DropTail
$ns duplex-link $n3 $n4 10Mb 10ms DropTail
$ns duplex-link $n4 $n5 10Mb 10ms DropTail
$ns duplex-link $n5 $n0 10Mb 10ms DropTail


set udp [new Agent/UDP]
$ns attach-agent $n2 $udp

set null [new Agent/Null]
$ns attach-agent $n0 $null

set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set packet_size_ 1000

$ns connect $udp $null

proc finish {} {
	global ns nf
	$ns flush-trace
	close $nf
	exec nam o.nam &
	exit 0
}



$ns at 0.1 "$cbr start"
$ns at 14.0 "$cbr stop"

$ns at 15.0 "finish"
$ns run
