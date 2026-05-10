/system identity set name=BUZAU

/ip address
add address=10.0.0.2/30 interface=ether1 comment="RADIO to BUCURESTI"
add address=10.0.0.9/30 interface=ether2 comment="RADIO to FOCSANI"
add address=10.0.0.13/30 interface=ether3 comment="RADIO to NOD1"
add address=10.255.0.2/32 interface=ether1 comment="Loopback Router-ID"

/routing ospf instance
add name=ospf1 version=2 router-id=10.255.0.2

/routing ospf area
add name=backbone instance=ospf1 area-id=0.0.0.0

/routing ospf interface-template
add interfaces=ether1 area=backbone type=ptp cost=1 hello-interval=10s dead-interval=60s
add interfaces=ether2 area=backbone type=ptp cost=1 hello-interval=10s dead-interval=60s
add interfaces=ether3 area=backbone type=ptp cost=1 hello-interval=10s dead-interval=60s
add interfaces=ether1 area=backbone networks=10.255.0.2/32

/tool netwatch
add host=10.0.0.1 interval=5s type=icmp down-script="/routing ospf interface-template set [find where interfaces=ether1 and type=ptp] cost=200" up-script=":delay 60s; :if ([/ping 10.0.0.1 count=5] > 0) do={/routing ospf interface-template set [find where interfaces=ether1 and type=ptp] cost=1}"
add host=10.0.0.10 interval=5s type=icmp down-script="/routing ospf interface-template set [find where interfaces=ether2 and type=ptp] cost=200" up-script=":delay 60s; :if ([/ping 10.0.0.10 count=5] > 0) do={/routing ospf interface-template set [find where interfaces=ether2 and type=ptp] cost=1}"
add host=10.0.0.14 interval=5s type=icmp down-script="/routing ospf interface-template set [find where interfaces=ether3 and type=ptp] cost=200" up-script=":delay 60s; :if ([/ping 10.0.0.14 count=5] > 0) do={/routing ospf interface-template set [find where interfaces=ether3 and type=ptp] cost=1}"
