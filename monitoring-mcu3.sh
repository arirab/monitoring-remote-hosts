    #!/bin/bash
    ip=X.X.X.X    #Change the IP address according to your need \
    fail_count=2  #Change the fail_count value according to your need \
    
    count=0
    trace_executed=0
    while [ 1 ]; do
      ping -c 1 $ip 1> /tmp/hostname-latency.txt
      result=$?

    if [ $result == "1" ]; then
	    echo FAIL!!! $ip on `date`	
	    echo FAIL!!! $ip on `date` >> ~/hostname-ping-fail.log	
      
    if [[ $count == $fail_count && $trace_executed == 0 ]]; then
	    echo '***'    
	    echo Taking trace! on `date`
       
      echo "Trace report generated on: $(date)" > ~/hostname-traceroute.log
   	  echo '---------------------------------------' >> ~/hostname-traceroute.log
      traceroute $ip >> ~/hostname-traceroute.log
      mail -s "Packet Loss: hostname | Trace Route Report" userid@example.com < ~/hostname-traceroute.log
   	  trace_executed=1   #Change the email id according to your need \

   	  echo 'Trace Report Emailed'
   	  echo '***'
      
      else
    	  ((count++))
       fi
     fi
     
    if [ $result == "0" ]; then 
	    echo PONG! $ip on `date`	
	    echo PONG! $ip on `date` >> ~/hostname-ping-success.log	
	    count=0
    fi
    sleep .5s
    done
