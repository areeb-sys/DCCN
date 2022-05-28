set ns [new Simulator]
set nf [open o1.nam w]
$ns namtrace-all $nf

#creating nodes
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]
set n10 [$ns node]
set n11 [$ns node]
set n12 [$ns node]
set n13 [$ns node]
set n14 [$ns node]

#creating connections
$ns duplex-link $n1 $n9 20Mb 10ms RED
$ns duplex-link $n2 $n9 20Mb 10ms RED
$ns duplex-link $n3 $n9 20Mb 10mS RED
$ns duplex-link $n4 $n9 20Mb 10ms RED
$ns duplex-link $n5 $n10 20Mb 10ms RED
$ns duplex-link $n6 $n10 20Mb 10ms RED
$ns duplex-link $n7 $n10 20Mb 10ms RED
$ns duplex-link $n8 $n10 20Mb 10ms RED
$ns duplex-link $n9 $n11 20Mb 10ms RED
$ns duplex-link $n10 $n11 20Mb 10ms RED
$ns duplex-link $n11 $n12 20Mb 10ms RED
$ns duplex-link $n11 $n13 20Mb 10ms RED
$ns duplex-link $n12 $n13 20Mb 10ms RED
$ns duplex-link $n12 $n14 20Mb 10ms RED

#applying tcp

set tcp1 [new Agent/TCP]
$ns  attach-agent $n1 $tcp1
set tcp2 [new Agent/TCP]
$ns  attach-agent $n2 $tcp2
set tcp3 [new Agent/TCP]
$ns  attach-agent $n3 $tcp3
set tcp4 [new Agent/TCP]
$ns  attach-agent $n4 $tcp4
#applying udp


set udp1 [new Agent/UDP]
$ns attach-agent $n5 $udp1
set udp2 [new Agent/UDP]
$ns attach-agent $n6 $udp2
set udp3 [new Agent/UDP]
$ns attach-agent $n7 $udp3
set udp4 [new Agent/UDP]
$ns attach-agent $n8 $udp4


set null1 [new Agent/TCPSink]
$ns attach-agent $n14 $null1
set null2 [new Agent/TCPSink]
$ns attach-agent $n14 $null2
set null3 [new Agent/TCPSink]
$ns attach-agent $n14 $null3
set null4 [new Agent/TCPSink]
$ns attach-agent $n14 $null4
set null5 [new Agent/LossMonitor]
$ns attach-agent $n14 $null5
set null6 [new Agent/LossMonitor]
$ns attach-agent $n14 $null6
set null7 [new Agent/LossMonitor]
$ns attach-agent $n14 $null7
set null8 [new Agent/LossMonitor]
$ns attach-agent $n14 $null8

set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $tcp1
$cbr1 set packet_size_ 1000
set cbr2 [new Application/Traffic/CBR]
$cbr2 attach-agent $tcp2
$cbr2 set packet_size_ 1000
set cbr3 [new Application/Traffic/CBR]
$cbr3 attach-agent $tcp3
$cbr3 set packet_size_ 1000
set cbr4 [new Application/Traffic/CBR]
$cbr4 attach-agent $tcp4
$cbr4 set packet_size_ 1000
set cbr5 [new Application/Traffic/CBR]
$cbr5 attach-agent $udp1
$cbr5 set packet_size_ 1000
set cbr6 [new Application/Traffic/CBR]
$cbr6 attach-agent $udp2
$cbr6 set packet_size_ 1000
set cbr7 [new Application/Traffic/CBR]
$cbr7 attach-agent $udp3
$cbr7 set packet_size_ 1000
set cbr8 [new Application/Traffic/CBR]
$cbr8 attach-agent $udp4
$cbr8 set packet_size_ 1000


$ns connect $tcp1 $null1
$ns connect $tcp2 $null2
$ns connect $tcp3 $null3
$ns connect $tcp4 $null4

$ns connect $udp1 $null5
$ns connect $udp2 $null6
$ns connect $udp3 $null7
$ns connect $udp4 $null8




set f0 [open out0.tr w] 
set f1 [open out1.tr w]
set f2 [open out2.tr w] 
set f3 [open out3.tr w]
set f4 [open out4.tr w] 
set f5 [open out5.tr w]
set f6 [open out6.tr w] 
set f7 [open out7.tr w]


#plot graph
proc traffic {} {
	global null1 null2 null3 null4 null5 null6 null7 null8 f0 f1 f2 f3 f4 f5 f6 f7 
	set ns [Simulator instance]
	set time 0.5
	set bw0 [$null1 set bytes_]
	set bw1 [$null2 set bytes_]
	set bw2 [$null3 set bytes_]
	set bw3 [$null4 set bytes_]
	set bw4 [$null5 set bytes_]
	set bw5 [$null6 set bytes_]
	set bw6 [$null7 set bytes_]
	set bw7 [$null8 set bytes_]



	set now [$ns now]

	puts $f0 "$now [expr $bw0/$time*8/1000000]" 
	puts $f1 "$now [expr $bw1/$time*8/1000000]"
	puts $f2 "$now [expr $bw2/$time*8/1000000]" 
	puts $f3 "$now [expr $bw3/$time*8/1000000]"
	puts $f4 "$now [expr $bw4/$time*8/1000000]" 
	puts $f5 "$now [expr $bw5/$time*8/1000000]"
	puts $f6 "$now [expr $bw6/$time*8/1000000]" 
	puts $f7 "$now [expr $bw7/$time*8/1000000]"
		
	$null1 set bytes_ 0
	$null2 set bytes_ 0
	$null3 set bytes_ 0
	$null4 set bytes_ 0
	$null5 set bytes_ 0
	$null6 set bytes_ 0
	$null7 set bytes_ 0
	$null8 set bytes_ 0
	$ns at [expr $now+$time] "traffic"
}

proc finish {} {
    global ns nf f0 f1 f2 f3 f4 f5 f6 f7 
    $ns flush-trace
    close $nf
	close $f0
	close $f1
	close $f2
	close $f3
	close $f4
	close $f5
	close $f6
	close $f7
    exec nam o1.nam &
	exec xgraph out0.tr out1.tr out2.tr out3.tr out4.tr out5.tr out6.tr out7.tr -geometry 700x400 &
    exit 0s
}

$ns at 0.0 "traffic"

$ns at 0.5 "$cbr1 start"
$ns at 1.0 "$cbr1 stop"

$ns at 1.5 "$cbr2 start"
$ns at 4.0 "$cbr2 stop"

$ns at 4.0 "$cbr3 start"
$ns at 8.0 "$cbr3 stop"

$ns at 8.0 "$cbr4 start"
$ns at 10.0 "$cbr4 stop"

$ns at 10.0 "$cbr5 start"
$ns at 14.0 "$cbr5 stop"

$ns at 14.0 "$cbr6 start"
$ns at 17.0 "$cbr6 stop"

$ns at 17.0 "$cbr7 start"
$ns at 18.0 "$cbr7 stop"

$ns at 18.0 "$cbr8 start"
$ns at 19.5 "$cbr8 stop"


$ns at 20.0 "finish"
$ns run
