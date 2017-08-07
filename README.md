# Pfam Info
### Purpose
This script is prepared to get the pfam domains using Gene symbol.It uses the Pfam API to retrieve domains, and the UniProt REST API to translate HGNC Gene Symbols into Uniprot/SwissProt Accession number
### Example Command 
```Perl
Perl Gene_Pfam.pl POLD1 POLD1_domain.txt 
```
### Example output
| Domian | Description  |   Start  | End |
| ------- | ------------| ---------| -----|
|DNA_pol_B_exo1 |  DNA polymerase family B, exonuclease domain |    130    | 477 |
|DNA_pol_B    |   DNA polymerase family B | 535    |  973 |
| zf-C4pol    |    C4-type zinc-finger of DNA polymerase delta |    1012  |  1082 |
