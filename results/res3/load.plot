#'!'/bin/sh
set terminal gif small
set output "load.gif"
set ylabel "End-to-end delay(s)"
set xlabel "No. of Nodes"
set key left top box
plot "aodv.data" title "aodv" with linespoints, "olsr.data" title "olsr" with linespoints
