#include <iostream>
#include <math.h>
#include "cuda_profiler_api.h"
// Kernel function to add the elements of two arrays
__global__
void add(int n, float* x)
{
  printf("%p\n", x);
  // x = 0;
  for(int i = 0; i < 100; i++){
    printf("%f\n", x[i+10]);
  }
}

void kk(){
  float* x;
  int size = 10;
  cudaMallocManaged(&x, size * sizeof(float));
  float b[] = {1.0f, 2.0f, 3.0f};
  // printf("%lld", sizeof(b));
  cudaMemcpy(x, b, sizeof(b), cudaMemcpyHostToDevice);
  printf("%p\n", b);

  add<<<1,1>>>(size, x);
  cudaDeviceSynchronize();  
  cudaFree(x);
}


// int main(void)
// {
//   float* x;
//   int size = 10;
//   cudaMallocManaged(&x, size * sizeof(float));
//   float b[] = {1.0f, 2.0f, 3.0f};
//   // printf("%lld", sizeof(b));
//   cudaMemcpy(x, b, sizeof(b), cudaMemcpyHostToDevice);
//   printf("%p\n", b);

//   add<<<1,1>>>(size, x);
//   cudaDeviceSynchronize();  
//   cudaFree(x);
//   return 0;
// }
