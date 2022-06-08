#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "M2libc/bootstrappable.h"

int main(int argc, char **argv)
{
    /* Get the size of the input file */
    FILE *infile = fopen(argv[1], "r");
    fseek(infile, 0, SEEK_END);
    int size = ftell(infile);
    fclose(infile);

    /* Create the src header */
    char* output = calloc(1024, sizeof(char));
    strcpy(output, "src ");
    strcat(output, int2str(size, 10, FALSE));
    strcat(output, " ");
    strcat(output, argv[1]);
    strcat(output, "\n");

    char* srcfile = calloc(1024, sizeof(char));
    strcpy(srcfile, argv[1]);
    strcat(srcfile, ".src");

    /* Write the header to output file */
    FILE *outfile = fopen(srcfile, "w");
    fputs(output, outfile);
    fclose(outfile);
}
