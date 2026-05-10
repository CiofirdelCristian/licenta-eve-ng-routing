/system identity set name=BUCURESTI

/ip address
add address=10.0.0.5/30 interface=ether1 comment="RADIO to NOD1"
add address=10.0.0.1/30 interface=ether2 comment="RADIO to BUZAU"
add address=192.168.245.10/24 interface=ether3 comment="MGMT WinBox"
add address=10.0.100.1/30 interface=ether4 comment="TROPO to FOCSANI"
add address=10.0.100.5/30 interface=ether5 comment="TROPO to GALATI"
add address=10.255.0.1/32 interface=ether1 comment="Loopback Router-ID"

/routing ospf instance
add name=ospf1 version=2 router-id=10.255.0.1

/routing ospf area
add name=backbone instance=ospf1 area-id=0.0.0.0

/routing ospf interface-template
add interfaces=ether1 area=backbone type=ptp cost=1 hello-interval=10s dead-interval=60s
add interfaces=ether2 area=backbone type=ptp cost=1 hello-interval=10s dead-interval=60s
add interfaces=ether4 area=backbone type=ptp cost=100
add interfaces=ether5 area=backbone type=ptp cost=100
add interfaces=ether1 area=backbone networks=10.255.0.1/32

/tool netwatch
add host=10.0.0.6 interval=5s type=icmp down-script="/routing ospf interface-template set [find where interfaces=ether1 and type=ptp] cost=200" up-script=":delay 60s; :if ([/ping 10.0.0.6 count=5] > 0) do={/routing ospf interface-template set [find where interfaces=ether1 and type=ptp] cost=1}"
add host=10.0.0.2 interval=5s type=icmp down-script="/routing ospf interface-template set [find where interfaces=ether2 and type=ptp] cost=200" up-script=":delay 60s; :if ([/ping 10.0.0.2 count=5] > 0) do={/routing ospf interface-template set [find where interfaces=ether2 and type=ptp] cost=1}"
