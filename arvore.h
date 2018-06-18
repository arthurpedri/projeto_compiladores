#include <string.h>
#include <stdlib.h>
#include <stdio.h>

typedef struct node {
    int qtd_filhos;
    struct node *filho[7];
    char nome[16];
} no;

void printarvore(no *raiz, int ultimo, int nivel);
no *subArvore(char *nome, int filhos, no *filho1, no *filho2, no *filho3, no *filho4, no *filho5, no *filho6, no *filho7);
no *novoNo(char *nome);

