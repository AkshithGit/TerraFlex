Azure Standard Load Balancer : 
Things we need to consider when we are creating Azure Standard Load Balancer
1. Public IP for the LB
2. Azure Standard LB itself
3. Backend Pool
4. Health Probe
5. Rule for Load balancer
6. Network interface backend address pool association  (This will associate the backend pool with the vms we are adding in the pool)

One other thing we need to know about the standard load balancer is Inbound Nat rules:
In this option we can connect to the backend pool machines by port mapping it from some slb_ip:custon_port_of_backend_pool_machine there by we can also do some work on the machines by logging in securely.

For the Inbound NAT rules we need to create:
1. Inbound LB NAT rule 
2. Network Interface nat rule association