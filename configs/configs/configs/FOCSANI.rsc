/system identity set name=FOCSANI

/ip address
add address=10.0.0.10/30 interface=ether1 comment="RADIO to BUZAU"
add address=10.0.0.17/30 interface=ether2 comment="RADIO to BACAU"
add address=10.0.0.21/30 interface=ether3 comment="RADIO to GALATI"
add address=10.0.100.2/30 interface=ether4 comment="TROPO to BUCURESTI"
add address=10.0.100.13/30 interface=ether5 comment="TROPO to IASI"
add address=10.0.100.9/30 interface=ether6 comment="TROPO to GALATI"
add address=10.255.0.3/32 interface=ether1 comment="Loopback Router-ID"

/routing ospf instance
add name=ospf1 version=2 router-id=10.255.0.3

/routing ospf area
add name=backbone instance=ospf1 area-id=0.0.0.0

/routing ospf interface-template
add interfaces=ether1 area=backbone type=ptp cost=1 hello-interval=10s dead-interval=60s
add interfaces=ether2 area=backbone type=ptp cost=1 hello-interval=10s dead-interval=60s
add interfaces=ether3 area=backbone type=ptp cost=1 hello-interval=10s dead-interval=60s
add interfaces=ether4 area=backbone type=ptp cost=100
add interfaces=ether5 area=backbone type=ptp cost=100
add interfaces=ether6 area=backbone type=ptp cost=100
add interfaces=ether1 area=backbone networks=10.255.0.3/32

/tool netwatch
add host=10.0.0.9 interval=5s type=icmp down-script="/routing ospf interface-template set [find where interfaces=ether1 and type=ptp] cost=200" up-script=":delay 60s; :if ([/ping 10.0.0.9 count=5] > 0) do={/routing ospf interface-template set [find where interfaces=ether1 and type=ptp] cost=1}"
add host=10.0.0.18 interval=5s type=icmp down-script="/routing ospf interface-template set [find where interfaces=ether2 and type=ptp] cost=200" up-script=":delay 60s; :if ([/ping 10.0.0.18 count=5] > 0) do={/routing ospf interface-template set [find where interfaces=ether2 and type=ptp] cost=1}"
add host=10.0.0.22 interval=5s type=icmp down-script="/routing ospf interface-template set [find where interfaces=ether3 and type=ptp] cost=200" up-script=":delay 60s; :if ([/ping 10.0.0.22 count=5] > 0) do={/routing ospf interface-template set [find where interfaces=ether3 and type=ptp] cost=1}"
