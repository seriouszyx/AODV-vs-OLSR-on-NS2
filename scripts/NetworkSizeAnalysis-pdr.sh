#!/bin/sh 

#判断以下文件是否存在,如果存在，则将其删除  
#scene-30n-0p-10M-150t-600-600 
if [ -f scene-30n-0p-10M-150t-600-600 ]; then  
         rm scene-30n-0p-10M-150t-600-600;  
fi 
#cbr-30n-10c-2p 
if [ -f cbr-30n-10c-2p ]; then  
         rm cbr-30n-10c-2p;  
fi 
#cbr-30n-10c-2p 
if [ -f cbr-30n-10c-2p ]; then  
         rm cbr-30n-10c-2p;  
fi 
#aodv.nam 
if [ -f aodv.nam  ]; then  
         rm aodv.nam ;  
fi 
#olsr.nam 
if [ -f olsr.nam  ]; then  
         rm olsr.nam ;  
fi 
#aodv.tr 
if [ -f aodv.tr  ]; then  
         rm aodv.tr ;  
fi 
#olsr.tr 
if [ -f olsr.tr  ]; then  
         rm olsr.tr ;  
fi 
#.rand_state
if [ -f .rand_state  ]; then  
         rm .rand_state ;  
fi 

for j in 200 300 600 800 1000  
do  
	 for i in $(seq 1 1 5)  
	 do  
			   ~/Documents/ns-allinone-2.35/ns-2.35/indep-utils/cmu-scen-gen/setdest/setdest -n 20 -p 30 -M 10 -t 150 -x $j -y $j > scene-30n-0p-10M-150t-600-600  
			   ns ~/Documents/ns-allinone-2.35/ns-2.35/indep-utils/cmu-scen-gen/cbrgen.tcl -type cbr -nn 20 -seed 1 -mc 10 -rate 2.0 > cbr-30n-10c-2p 
				
			   #使用AODV协议模拟
			   ns aodv.tcl 20 $j $j;  
			   nawk -v outfile=aodv.temp -v scr=$i -f getRatio.awk aodv.tr  

			   #使用OLSR协议模拟
			   ns olsr.tcl 20 $j $j; 
			   nawk -v outfile=olsr.temp -v scr=$i -f getRatio.awk olsr.tr  
	 done  
	 nawk -v outfile=aodv.data -v time=$j -f average.awk aodv.temp 
	 rm aodv.temp  

	 nawk -v outfile=olsr.data -v time=$j -f average.awk olsr.temp 
	 rm olsr.temp  
done 

echo "#'!'/bin/sh" >> networksize.plot  
echo "set terminal gif small" >> networksize.plot  
echo "set output \"networksize.gif\"" >> networksize.plot  
echo "set ylabel \"PDR(%)\"" >> networksize.plot  
echo "set xlabel \"Network Size\"" >> networksize.plot  
echo "set key left top box" >> networksize.plot   
echo "plot \"aodv.data\" title \"aodv\" with linespoints, \"olsr.data\" title \"olsr\" with linespoints" >> networksize.plot  
   
gnuplot networksize.plot  