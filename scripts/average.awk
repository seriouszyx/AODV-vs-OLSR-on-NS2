BEGIN{  
         average=0.0;  
		 sum = 0;
}  
{  
         if($1=="1"){  
                   average=average + $2;  
				   sum++;
         }  
         if($1=="2"){  
                   average=average + $2;  
				   sum++;
         }  
         if($1=="3"){  
                   average=average + $2;  
				   sum++;
         }  
         if($1=="4"){  
                   average=average + $2;  
				   sum++;
         }  
         if($1=="5"){  
                   average=average + $2;  
				   sum++;
         }  
}  
END {  
         printf "%d %.4f \n",time, (average/sum) >> outfile;  
}  
