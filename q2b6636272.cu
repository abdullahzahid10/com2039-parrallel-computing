/*************************************
**Question 2b
*************************************/
#include <stdio.h>

// Function which will print our desired output.
__global__ void printSuccessForCorrectExecutionConfiguration()
{

  if(threadIdx.x == 1023 && blockIdx.x == 255)
  {
    printf("Success!\n");
  }

}

//Main method responsible for ptinting out whether everything has gone to plan
int main()
{

//	Here there are two numbers. 256 defines the amount of blocks and the amount of threads is set to 1024. We need to print success, providing the set conditions
//	are matche.
  printSuccessForCorrectExecutionConfiguration<<<256, 1024>>>();

//  Device sync method
  cudaDeviceSynchronize();

  return 0;
}
