/system identity set name=NOD1

/ip address
add address=10.0.0.14/30 interface=ether1 comment="RADIO to BUZAU"
add address=10.0.0.6/30 interface=ether2 comment="RADIO to BUCURESTI"
add address=10.0.0.42/30 interface=ether3 comment="RADIO to GALATI"
add address=10.255.0.8/32 interface=ether1 comment="Loopback Router-ID"

/routing ospf instance
add name=ospf1 version=2 router-id=10.255.0.8

/routing ospf area
add name=backbone instance=ospf1 area-id=0.0.0.0

/routing ospf interface-template
add interfaces=ether1 area=backbone type=ptp cost=1 hello-interval=10s dead-interval=60s
add interfaces=ether2 area=backbone type=ptp cost=1 hello-interval=10s dead-interval=60s
add interfaces=ether3 area=backbone type=ptp cost=1 hello-interval=10s dead-interval=60s
add interfaces=ether1 area=backbone networks=10.255.0.8/32

/tool netwatch
add host=10.0.0.13 interval=5s type=icmp down-script="/routing ospf interface-template set [find where interfaces=ether1 and type=ptp] cost=200" up-script=":delay 60s; :if ([/ping 10.0.0.13 count=5] > 0) do={/routing ospf interface-template set [find where interfaces=ether1 and type=ptp] cost=1}"
add host=10.0.0.5 interval=5s type=icmp down-script="/routing ospf interface-template set [find where interfaces=ether2 and type=ptp] cost=200" up-script=":delay 60s; :if ([/ping 10.0.0.5 count=5] > 0) do={/routing ospf interface-template set [find where interfaces=ether2 and type=ptp] cost=1}"
add host=10.0.0.41 interval=5s type=icmp down-script="/routing ospf interface-template set [find where interfaces=ether3 and type=ptp] cost=200" up-script=":delay 60s; :if ([/ping 10.0.0.41 count=5] > 0) do={/routing ospf interface-template set [find where interfaces=ether3 and type=ptp] cost=1}"
