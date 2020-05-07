# Second Task
**Question**: 
2. Imagine a server with the following specs:
-  4 times Intel(R) Xeon(R) CPU E7-4830 v4 @ 2.00GHz
-  64GB of ram
-  2 tb HDD disk space
-  2 x 10Gbit/s nics

The server is used for SSL offloading and proxies around 25000 requests per second.

Please let us know which metrics are interesting to monitor in that specific case and how would you do that? What are the challenges of monitoring this?

**Answer**

**Core Metrics/Resources:**
- Service Monitor: The most important Metric of all. Ensuring the SSL Offloader / Proxy service is running.
- CPU: One of the Core resource we need to monitor. The encryption and decryption is CPU intensive and can put Load on the Server.
- Network: With 25000 requests per second, bandwidth consumption can go high. The thresholds should be set according to the benchmark of the current infrastructure.
- Disk: Disk I/O. More important if the disk is draining out its life.
- Memory: The importance and numbers of this metric varies according to the application/service used for proxy/SSL offloading.

**Secondary Metrics:**
- 5xx errors: Give internal visibility. High numbers could mean the SSL offloader is failing OR the backend service is not responding/ on time. 
- Request Response time / Latency: If the numbers from this metric increases, then an investigation is needed ( from SSL Offloader to Application server ).
- File descriptors limit: Considering High number of connection, the limit for File descriptor should be increased and Monitored.
- TCP established Connection: This tells us the total number of TCP connections established on the system ( Inbound / Outbound ). Anomaly in these metrics can point to the fact that there is a problem in the web process.
- SSL Certificate expiry monitor: So we are aware in the early stage of certificate expiration.


**Monitoring**

**Core Metrics/Resources**: I will use a combination of Prometheus and telegraf ( as an agent ) to monitor all the core resources ( https://github.com/influxdata/telegraf)

**Secondary Metrics**: 

**5xx errors/Request Response time**: I will put two front for this monitor. First From external tool ( to check from the internet > SSL offloader ) and the second would be internal ( SSL Offloader > Webserver ). For internal, I will use telegraf HTTP input plugin
https://github.com/influxdata/telegraf/blob/master/plugins/inputs/http_response/README.md

**File descriptors limit**: Telegraf with following plugin ( or a separate bash script )
https://github.com/influxdata/telegraf/blob/master/plugins/inputs/linux_sysctl_fs/README.md

**TCP established Connection**: Telegraf with following Plugin :
https://github.com/influxdata/telegraf/blob/master/plugins/inputs/net/NETSTAT_README.md

**SSL certificate expiry monitor**: External Monitor using 3rd Party or Telegraf with following Plugin:
https://github.com/influxdata/telegraf/blob/master/plugins/inputs/x509_cert/README.md
