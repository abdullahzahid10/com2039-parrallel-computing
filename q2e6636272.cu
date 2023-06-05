/*************************************
**Question 2e
*************************************/
#include <stdio.h>

// Initialise method with a for loop. Will print all values from 0 all the way to what integer is stored in N.
void init(int *a, int N)
{
  int i;
  for (i = 0; i < N; ++i)
  {
    a[i] = i;
  }
}

// The purpose of this function is to double a providing that thread is lower than a.

__global__ void doubleElements(int *a, int N)
{
  int i;
  i = blockIdx.x * blockDim.x + threadIdx.x;
  if (i < N)
  {
    a[i] *= 2;
  }
}

// A boolean method, which is pivotal for the code to meet its requirement. The code in here will check whether the a has doubled.
// Also notice that it has 2 return clauses, whereby, it will return true if the above clause is met, otherwise it will return the latter.
bool checkElementsAreDoubled(int *a, int N)
{
  int i;
  for (i = 0; i < N; ++i)
  {
    if (a[i] != i*2) return false;
  }
  return true;
}

int main()
{
//Initialising n to be 100 and initialising a pointer for a.
  int N = 100;
  int *a;

//  This var will store the amount of elements in the list.
  size_t size = N * sizeof(int);

//
  cudaMallocManaged(&a, size);

//  a = (int *)malloc(size);

// Calling the function to initialize variables.
  init(a, N);

//  Initializing two key variables which will be used later to be 10.
  size_t threads_per_block = 10;
  size_t number_of_blocks = 10;

  doubleElements<<<number_of_blocks, threads_per_block>>>(a, N);
  cudaDeviceSynchronize();

//  Boolean variable which will indicate as to the integers have been doubled.
  bool areDoubled = checkElementsAreDoubled(a, N);

  printf("All elements were doubled? %s\n", areDoubled ? "TRUE" : "FALSE");

  cudaFree(a);
}
