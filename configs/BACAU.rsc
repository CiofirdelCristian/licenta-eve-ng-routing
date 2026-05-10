/system identity set name=BACAU

/ip address
add address=10.0.0.18/30 interface=ether1 comment="RADIO to FOCSANI"
add address=10.0.0.25/30 interface=ether2 comment="RADIO to IASI"
add address=10.0.0.29/30 interface=ether3 comment="RADIO to NOD2"
add address=10.255.0.4/32 interface=ether1 comment="Loopback Router-ID"

/routing ospf instance
add name=ospf1 version=2 router-id=10.255.0.4

/routing ospf area
add name=backbone instance=ospf1 area-id=0.0.0.0

/routing ospf interface-template
add interfaces=ether1 area=backbone type=ptp cost=1 hello-interval=10s dead-interval=60s
add interfaces=ether2 area=backbone type=ptp cost=1 hello-interval=10s dead-interval=60s
add interfaces=ether3 area=backbone type=ptp cost=1 hello-interval=10s dead-interval=60s
add interfaces=ether1 area=backbone networks=10.255.0.4/32

/tool netwatch
add host=10.0.0.17 interval=5s type=icmp down-script="/routing ospf interface-template set [find where interfaces=ether1 and type=ptp] cost=200" up-script=":delay 60s; :if ([/ping 10.0.0.17 count=5] > 0) do={/routing ospf interface-template set [find where interfaces=ether1 and type=ptp] cost=1}"
add host=10.0.0.26 interval=5s type=icmp down-script="/routing ospf interface-template set [find where interfaces=ether2 and type=ptp] cost=200" up-script=":delay 60s; :if ([/ping 10.0.0.26 count=5] > 0) do={/routing ospf interface-template set [find where interfaces=ether2 and type=ptp] cost=1}"
add host=10.0.0.30 interval=5s type=icmp down-script="/routing ospf interface-template set [find where interfaces=ether3 and type=ptp] cost=200" up-script=":delay 60s; :if ([/ping 10.0.0.30 count=5] > 0) do={/routing ospf interface-template set [find where interfaces=ether3 and type=ptp] cost=1}"
