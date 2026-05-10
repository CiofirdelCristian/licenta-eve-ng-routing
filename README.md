# Simulare EVE-NG – Rețea de radiorelee cu backup troposferic

Acest repository conține configurațiile routerelor MikroTik CHR utilizate într-o topologie EVE-NG pentru simularea unei rețele de comunicații radio.

Rețeaua utilizează:
- legături de radioreleu ca rută principală;
- legături troposferice ca rută de rezervă;
- protocol OSPF pentru rutare dinamică;
- costuri OSPF diferite pentru prioritizarea rutelor;
- mecanism Netwatch pentru protecție la instabilitatea legăturilor.

## Configurații routere

Fișierele de configurare se află în folderul `configs`.

- BUCURESTI.rsc
- BUZAU.rsc
- FOCSANI.rsc
- BACAU.rsc
- IASI.rsc
- GALATI.rsc
- NOD1.rsc
- NOD2.rsc
