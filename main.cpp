// ssb/main.cpp
// PT: ficheiro principal
// EN: main file
// ==========================================================================================================================
// PT: pré-processador
// ==========================================================================================================================
#include "library.h"
#include "detect.h"
// ==========================================================================================================================
// PT: secção de código
// ==========================================================================================================================
// --------------------------------------------------------------------------------------------------------------------------
// PT: função main
void main(void)
{
  /*
   * PT:
   * - a função main (esta) é a primeira a ser executada
   * - de notar que, ao contrário da função main que tipicamente se faz para aplicações a correrem num sistema operativo,
   * esta não devolve inteiro nem recebe parâmetros, pois não há sistema operativo para avaliar o resultado, para passar
   * parâmetros ao programa durante o seu arranque
   * - terminada esta função, o sistema é bloqueado pelo código existente no ssb.asm
   */
  // PT: obrigatório: descomentar esta linha e substituir X pela letra e Y pelo número do grupo
  // PT: sim, são dados que poderiam estar estáticos dentro da string, mas isto serve para demonstrar como se usa o printf
  printf("Isto é o SSB do grupo %c%d.\r\n", 'B', 0);
  // PT: a função printz é ideal para imprimir strings terminadas em zero sem formatação
  printz("Detecting hardware...\r\n");
  // PT: a função printf permite formatar texto mas é mais lenta que a printz
  printf("Stack segment at 0x%x\r\n", get_stacksegment());
  
  // PT: descomentar os seguintes printfs conforme apropriado, acrescentar novos conforme apropriado
  printf("Data segment at 0x%x\r\n", get_datasegment());
  printf("Code segment at 0x%x\r\n", get_codesegment());
  int ndisk = get_diskcount();
  printf("Numeros de discos %u\r\n", ndisk); 
  for  ( int i = 0; i < ndisk; ++i)
  {
	printf("Tamanho do disco %u\r\n", get_disksize(0x80+i));
  }
  //printf("Total da memória  %u\r\n", get_totalmem());
  printf("Data  %s\r\n", get_date());
  printf("Tempo  %s\r\n", get_time());
  