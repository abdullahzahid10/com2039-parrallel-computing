// In this question I will provide a complete implementation of a parallel algorithm that will Reduce a 1D array of
//elements into a single summary value, where the size of the input array will require the use
//of multiple blocks of threads. The reduction should give the sum of the list.

#include <stdio.h>
#include <assert.h>

//Inclusion of Cuda Error Handling
inline cudaError_t checkCuda(cudaError_t proceed)
{
  if (proceed != cudaSuccess) {
    fprintf(stderr, "Error... %s\n", cudaGetErrorString(proceed));
    assert(proceed == cudaSuccess);
  }
  return proceed;
}

// Initialising the method.
void initialisingStage(float number, float *a, int N)
{
  for(int i = 0; i < N; ++i)
  {
    a[i] = number;
  }
}

//Add vectors into the array
__global__ void additionPhase(float *proceed, float *a, float *b, int N)
{
  int index = threadIdx.x + blockIdx.x * blockDim.x;
  int stride = blockDim.x * gridDim.x;

  for(int i = index; i < N; i += stride)
  {
    proceed[i] = a[i] + b[i];
  }
}

//Check elements are within the array to reduce
void checkElementsAre(float target, float *array, int N)
{
  for(int i = 0; i < N; i++)
  {
    if(array[i] != target)
    {
      printf("FAIL: array[%d] - %0.0f does not equal %0.0f\n", i, array[i], target);
      exit(1);
    }
  }
  printf("1D Array has been successfully reduces.\n");
}

//Main method
int main()
{
  const int N = 2<<20;
  size_t size = N * sizeof(float);

//  Pointers initialised
  float *a;
  float *b;
  float *c;

//  Error handling in the main method
  checkCuda( cudaMallocManaged(&a,size));
  checkCuda( cudaMallocManaged(&b,size));
  checkCuda( cudaMallocManaged(&c,size));


//Initializing phase
  initialisingStage(3, a, N);
  initialisingStage(4, b, N);
  initialisingStage(0, c, N);

//  Initializing threads per block and the amount of blocks.
  size_t threadsPerBlock;
  size_t numberOfBlocks;

//  Putting per block as 256
  threadsPerBlock = 256;
  numberOfBlocks = (N + threadsPerBlock - 1) / threadsPerBlock;

//  Add vectors into the array
  additionPhase<<<numberOfBlocks, threadsPerBlock>>>(c, a, b, N);

//  Check for any errors and make synchronisations where required.
  checkCuda( cudaGetLastError() );
  checkCuda( cudaDeviceSynchronize() );

//  Sync all entities including threads.
  cudaDeviceSynchronize();

//  Check everything is in order
  checkElementsAre(7, c, N);

//  Free up any memory which is allocated.
  cudaFree(a);
  cudaFree(b);
  cudaFree(c);
}