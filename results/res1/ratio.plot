#'!'/bin/sh
set terminal gif small
set output "ratio.gif"
set ylabel "PDR(%)"
set xlabel "Pause time(s)"
set key left top box
plot "aodv.data" title "aodv" with linespoints, "olsr.data" title "olsr" with linespoints
