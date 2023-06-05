/*************************************
**Question 2c
*************************************/

#include <stdio.h>

/*
 * Refactor `loop` to be a CUDA Kernel. The new kernel should
 * only do the work of 1 iteration of the original loop.
 */

//I have used __global__ before void so the code is run of the GPU. In the method the for loop is run from GPU.
__global__ void loop(int N)
{
  for (int i = 0; i < N; ++i)
  {
    printf("This is iteration number %d\n", i);
  }
}

int main()
{

//The execution content to set out amount of loops which will occur.

  int N = 10;

//  In the loop<<<>>> syntax, i put 1,1. The first one will be 1 block and the latter being 1 thread.
  loop<<<1, 1>>>(N);

  cudaDeviceSynchronize();
  return 0;


}
