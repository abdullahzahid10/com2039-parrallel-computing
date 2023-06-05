/*************************************
**Question 2D
*************************************/

#include <stdio.h>

//Here i will refactor the the loop so that is a CUDA Kernel. This should only do 1 iteration of the original loop

__global__ void loop(int N)
{

//	The aim of idx and str is to ensure each iteration of numbers are printed out on one occasion/

  int idx = blockIdx.x * blockDim.x + threadIdx.x;
  int str = gridDim.x * blockDim.x;

  for (int i = idx; i < N; i += str)
  {
    printf("This is iteration number %d\n", i);
  }
}

int main()
{
//The question requirement requires me to use 2 blocks of threads.

//	Amount of times the for loop will run till.
  int N = 10;

//  Here i used 2 blocks of thread followed by 1 which is the block size.
  loop<<<2, 1>>>(N);

//  Device sync method
  cudaDeviceSynchronize();

  return 0;
}
