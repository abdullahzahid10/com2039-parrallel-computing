/*************************************
**Question 2a
*************************************/
#include <stdio.h>

void helloCPU(){
    printf("Hello from the CPU.\n");
}

//I have used __global__ before void so the code is run of the GPU. In the method, I have printed a message to indicate the method is run from GPU.

__global__ void helloGPU()
{
  printf("Hello from the GPU.\n");
}

// Now to run the code on the GPU
int main()
{


//	An execution configuration with the helloGPU<<<>>> syntax will run this as a kernel from the GPU. The first iteration of 1 will indicate the amount of blocks in and the size of the blocks
	helloGPU<<<1, 1>>>();

//	The purpose of this is so that it will hinder the CPU Stream until the GPU kernels have finished.
	cudaDeviceSynchronize();

	helloCPU();

	return 0;

}
