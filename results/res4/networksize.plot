#'!'/bin/sh
set terminal gif small
set output "networksize.gif"
set ylabel "End-to-end delay(s)"
set xlabel "Network Size"
set key left top box
plot "aodv.data" title "aodv" with linespoints, "olsr.data" title "olsr" with linespoints
