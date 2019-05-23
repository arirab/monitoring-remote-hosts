    #!/bin/bash
    ip=X.X.X.X   `#Change the IP address according to your need` \
    fail_count=2 `#Change the fail-count value according to your need ` \
    
    count=0
    trace_executed=0
    while [ 1 ]; do
      ping -c 1 $ip 1> /tmp/latency-mcu3.txt
      result=$?

    if [ $result == "1" ]; then
	    echo FAIL!!! on `date`
	    echo FAIL!!! on `date` >> ~/mcu3-ping-fail.log
      
    if [[ $count == $fail_count && $trace_executed == 0 ]]; then
	    echo '***'    
	    echo Taking trace! on `date`
       
      echo "Trace report generated on: $(date)" > ~/mcu3-traceroute.log
   	  echo '---------------------------------------' >> ~/mcu3-traceroute.log
      traceroute $ip >> ~/mcu3-traceroute.log
      mail -s "Packet Loss: mcu3 | Trace Route Report" userid@example.com < ~/mcu3-traceroute.log
   	  trace_executed=1   `#Change the email id according to your need ` \

   	  echo 'Trace Report Emailed'
   	  echo '***'
      
      else
    	  ((count++))
       fi
     fi
     
    if [ $result == "0" ]; then 
	    echo PONG! on `date`
	    echo PONG! on `date` >> ~/mcu3-ping-success.log
	    count=0
    fi
    sleep .5s
    done
