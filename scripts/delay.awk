# 使用的是无线 Trace 的旧格式
BEGIN {
	highest_packet_id = 0;		# highest_uid 会保存已处理过的分组中最大的 uid
}
{
	action = $1;				# 第1个字段 $1 标识事件的类型
	time = $2;					# 第2个字段 $2 标识事件发生的时间
	packet_id = $6;				# 第6个字段 $6 为分组的 uid
	type = $7;					# 第7个字段 $7 为分组的类型
	
	# 不考虑路由包，可以保证序号为0的 cbr 被统计到
	if ( type == "cbr" ) {
   
		# 更新 highest_packet_id
		if ( packet_id > highest_packet_id )
			highest_packet_id = packet_id;
	 
		#记录封包的传送时间
		if ( start_time[packet_id] == 0 )  
			start_time[packet_id] = time;
	 
		#记录CBR 的接收时间
		if (  action != "D" ) {
			if ( action == "r" ) {
				end_time[packet_id] = time;
			}
		} else {
			#把不符合条件的数据包的时间设为-1
			end_time[packet_id] = -1;
	   }
	}	
}
END {
	#当资料列全部读取完后，开始计算有效封包的端点到端点延迟时间 
	sum = 0;
    for ( packet_id = 0; packet_id <= highest_packet_id; packet_id++ ) {
		start = start_time[packet_id];
		end = end_time[packet_id];
		packet_duration = end - start;
 
		#只把接收时间大于传送时间的记录列出来
		if ( start < end ) sum += packet_duration;
   }
   printf "%d %.4f\n", scr, (sum / (highest_packet_id + 1)) >> outfile;
}
