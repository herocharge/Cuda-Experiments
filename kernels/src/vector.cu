#include "pop_vector.h"
#include <stdio.h>
#include <stdlib.h>

__global__
void vec_add_kernel(unsigned int size, const float* op1, const float* op2, float* result){
    unsigned int bidx = blockIdx.x;
    unsigned int bsize = blockDim.x;
    unsigned int tidx = threadIdx.x;
    unsigned int idx = bidx * bsize + tidx;
    result[idx] = op1[idx] + op2[idx];
}

__global__
void vec_mul_kernel(unsigned int size, const float* op1, const float* op2, float* result){
    unsigned int bidx = blockIdx.x;
    unsigned int bsize = blockDim.x;
    unsigned int tidx = threadIdx.x;
    unsigned int idx = bidx * bsize + tidx;
    result[idx] = op1[idx] * op2[idx];
}


void vec_add(const unsigned int size, const float* a, const float* b, float** c){

    const unsigned int num_bytes = sizeof(float) * size;

    // if mem not allocated, allocate required memory
    if(*c == NULL){
        *c = (float *)malloc(num_bytes);
    }

    // pointers to operands in gpu
    float* op1_gpu;
    float* op2_gpu;

    float* result_gpu;
    
    // allocate memory in the gpu
    cudaMallocManaged(&op1_gpu, num_bytes);
    cudaMallocManaged(&op2_gpu, num_bytes);
    cudaMallocManaged(&result_gpu, num_bytes);

    // copy the operantds to GPU
    cudaMemcpy(&op1_gpu, a, num_bytes, cudaMemcpyHostToDevice);
    cudaMemcpy(&op2_gpu, b, num_bytes, cudaMemcpyHostToDevice);

    const unsigned int nthreads = 256;
    const unsigned int nblocks = (size % 256) ? (size / 256 + 1) : (size / 256);

    // do the operation
    vec_add_kernel<<<nblocks, nthreads>>>(size, op1_gpu, op2_gpu, result_gpu);

    cudaMemcpy(*c, result_gpu, num_bytes, cudaMemcpyDeviceToHost);

    // returning before freeing might be faster??
    cudaFree(op1_gpu);
    cudaFree(op2_gpu);
}


void vec_mul(const unsigned int size, const float* a, const float* b, float** c){

    const unsigned int num_bytes = sizeof(float) * size;

    // if mem not allocated, allocate required memory
    if(*c == NULL){
        *c = (float *)malloc(num_bytes);
    }

    // pointers to operands in gpu
    float* op1_gpu;
    float* op2_gpu;

    float* result_gpu;
    
    // allocate memory in the gpu
    cudaMallocManaged(&op1_gpu, num_bytes);
    cudaMallocManaged(&op2_gpu, num_bytes);
    cudaMallocManaged(&result_gpu, num_bytes);

    // copy the operantds to GPU
    cudaMemcpy(&op1_gpu, a, num_bytes, cudaMemcpyHostToDevice);
    cudaMemcpy(&op2_gpu, b, num_bytes, cudaMemcpyHostToDevice);

    const unsigned int nthreads = 256;
    const unsigned int nblocks = (size % 256) ? (size / 256 + 1) : (size / 256);

    // do the operation
    vec_mul_kernel<<<nblocks, nthreads>>>(size, op1_gpu, op2_gpu, result_gpu);

    cudaMemcpy(*c, result_gpu, num_bytes, cudaMemcpyDeviceToHost);

    // returning before freeing might be faster??
    cudaFree(op1_gpu);
    cudaFree(op2_gpu);
}