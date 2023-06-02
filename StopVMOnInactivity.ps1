   $idleThreshold = 10 # Inactivity threshold in minutes
   $idleTime = 0

   while ($true) {
       Start-Sleep -Seconds 60
       $cpuUsage = (Get-Counter -Counter "\Processor(_Total)\% Processor Time" -SampleInterval 1 -MaxSamples 5 |
           Measure-Object -Property CounterSamples -Average).Average

       if ($cpuUsage -lt 10) {
           $idleTime += 1
       } else {
           $idleTime = 0
       }

       if ($idleTime -ge $idleThreshold) {
           az vm stop --name WindowsTen --resource-group FREE
           break
       }
   }
