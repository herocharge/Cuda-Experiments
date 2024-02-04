/* GPT gen */
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "pop_vector.h"

#define SIZE 100000000


void vectorAdd(float *a, float *b, float *result, int size) {
    for (int i = 0; i < size; ++i) {
        result[i] = a[i] + b[i];
    }
}

int main() {
    float *a, *b, *result;
    clock_t start, end;

    // Allocate memory for vectors
    a = (float *)malloc(SIZE * sizeof(float));
    b = (float *)malloc(SIZE * sizeof(float));
    result = (float *)malloc(SIZE * sizeof(float));

    // Initialize vectors with random values
    for (int i = 0; i < SIZE; ++i) {
        a[i] = (float)rand() / RAND_MAX;
        b[i] = (float)rand() / RAND_MAX;
    }

    // Benchmark vector addition
    start = clock();
    vectorAdd(a, b, result, SIZE);
    end = clock();

    // Calculate elapsed time
    double cpu_time_used = ((double)(end - start)) / CLOCKS_PER_SEC;
    printf("Normal Vector addition took %f seconds\n", cpu_time_used);

    // Benchmark vector addition using the function from the shared object
    start = clock();
    vec_add(SIZE, a, b, &result);
    end = clock();

    // Calculate elapsed time
    cpu_time_used = ((double)(end - start)) / CLOCKS_PER_SEC;
    printf("GPU Vector addition took %f seconds\n", cpu_time_used);

    // Free allocated memory
    free(a);
    free(b);
    free(result);

    return 0;
}
