Prototip complet procesor RISC-V

Am implementat stagiile IF, ID, EX, MEM, WB si doua unitati 
auxiliare pentru detectia hazardurilor si pentru unitatea de
forwarding.

Fiecare instructiune este decodificata, analizand tipul acesteia,
dupa care se executa operatia artimetico-logica din interiorul ei.
Citim asincron sau scriem sincron  datele in memorie (4 KB).

In final, scriem rezultatul in bancul de registre.
Folosesc un multiplexor pentru rezultat, deoarece exista doua cazuri:
  1. citim valoarea din memoria de date daca avem o instructiune LW
  2. citim valoarea calculata de ALU, in cazul instructiunilor R-type
     sau I-type (ALU poate realiza operatii intre doua registre dar si
     intre un registru si o valoare imediata
