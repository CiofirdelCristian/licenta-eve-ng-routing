/system identity set name=IASI

/ip address
add address=10.0.0.33/30 interface=ether1 comment="RADIO to NOD2"
add address=10.0.0.26/30 interface=ether2 comment="RADIO to BACAU"
add address=10.0.100.14/30 interface=ether3 comment="TROPO to FOCSANI"
add address=10.0.100.18/30 interface=ether4 comment="TROPO to GALATI"
add address=10.255.0.5/32 interface=ether1 comment="Loopback Router-ID"

/routing ospf instance
add name=ospf1 version=2 router-id=10.255.0.5

/routing ospf area
add name=backbone instance=ospf1 area-id=0.0.0.0

/routing ospf interface-template
add interfaces=ether1 area=backbone type=ptp cost=1 hello-interval=10s dead-interval=60s
add interfaces=ether2 area=backbone type=ptp cost=1 hello-interval=10s dead-interval=60s
add interfaces=ether3 area=backbone type=ptp cost=100
add interfaces=ether4 area=backbone type=ptp cost=100
add interfaces=ether1 area=backbone networks=10.255.0.5/32

/tool netwatch
add host=10.0.0.34 interval=5s type=icmp down-script="/routing ospf interface-template set [find where interfaces=ether1 and type=ptp] cost=200" up-script=":delay 60s; :if ([/ping 10.0.0.34 count=5] > 0) do={/routing ospf interface-template set [find where interfaces=ether1 and type=ptp] cost=1}"
add host=10.0.0.25 interval=5s type=icmp down-script="/routing ospf interface-template set [find where interfaces=ether2 and type=ptp] cost=200" up-script=":delay 60s; :if ([/ping 10.0.0.25 count=5] > 0) do={/routing ospf interface-template set [find where interfaces=ether2 and type=ptp] cost=1}"
