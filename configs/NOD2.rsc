/system identity set name=NOD2

/ip address
add address=10.0.0.34/30 interface=ether1 comment="RADIO to IASI"
add address=10.0.0.37/30 interface=ether2 comment="RADIO to GALATI"
add address=10.0.0.30/30 interface=ether3 comment="RADIO to BACAU"
add address=10.255.0.6/32 interface=ether1 comment="Loopback Router-ID"

/routing ospf instance
add name=ospf1 version=2 router-id=10.255.0.6

/routing ospf area
add name=backbone instance=ospf1 area-id=0.0.0.0

/routing ospf interface-template
add interfaces=ether1 area=backbone type=ptp cost=1 hello-interval=10s dead-interval=60s
add interfaces=ether2 area=backbone type=ptp cost=1 hello-interval=10s dead-interval=60s
add interfaces=ether3 area=backbone type=ptp cost=1 hello-interval=10s dead-interval=60s
add interfaces=ether1 area=backbone networks=10.255.0.6/32

/tool netwatch
add host=10.0.0.33 interval=5s type=icmp down-script="/routing ospf interface-template set [find where interfaces=ether1 and type=ptp] cost=200" up-script=":delay 60s; :if ([/ping 10.0.0.33 count=5] > 0) do={/routing ospf interface-template set [find where interfaces=ether1 and type=ptp] cost=1}"
add host=10.0.0.38 interval=5s type=icmp down-script="/routing ospf interface-template set [find where interfaces=ether2 and type=ptp] cost=200" up-script=":delay 60s; :if ([/ping 10.0.0.38 count=5] > 0) do={/routing ospf interface-template set [find where interfaces=ether2 and type=ptp] cost=1}"
add host=10.0.0.29 interval=5s type=icmp down-script="/routing ospf interface-template set [find where interfaces=ether3 and type=ptp] cost=200" up-script=":delay 60s; :if ([/ping 10.0.0.29 count=5] > 0) do={/routing ospf interface-template set [find where interfaces=ether3 and type=ptp] cost=1}"
