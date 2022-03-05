O projecto é constituído por duas pastas, mbr e ssb, e um Makefile.

Editar esta secção
Instalação
É necessário ter acesso Internet e configurar uma ligação VPN (Virtual Private Network) utilizando as credenciais da área privada.


Documentação
https://stanislavs.org/helppc/
https://en.wikipedia.org/wiki/INT_13H
https://wiki.osdev.org/Main_Page


Funções
Código fonte das funções: no ficheiro ssb/detect.asm
Ficheiro que imprime o valor das funções: ssb/main.cpp

1. Obter o valor do registo Data Segment - devem implementar a função “get_datasegment”

2. Obter o valor do registo Code Segment - devem implementar a função “get_codesegment”

3. Obter o número de discos instalados - devem implementar a função “get_diskcount”
https://stanislavs.org/helppc/bios_data_area.html

4. Obter o tamanho de um disco - devem implementar a função “get_disksize”
https://en.wikipedia.org/wiki/INT_13H#INT_13h_AH=48h:_Extended_Read_Drive_Parameters

5. Obter o tamanho de cada um dos discos instalados – depende da execução das tarefas 3 e 4
https://www.w3schools.com/cpp/cpp_for_loop.asp

6. Obter a data actual - devem implementar a função “get_date”
https://stanislavs.org/helppc/int_1a-4.html
https://www.daniweb.com/programming/software-development/threads/118259/print-out-date-time-assignment

7. Obter a hora actual - devem implementar a função “get_time”
https://stanislavs.org/helppc/int_1a-2.html

8. (Em desenvolvimento) Obter o tamanho da memória
http://uruk.org/orig-grub/mem64mb.html