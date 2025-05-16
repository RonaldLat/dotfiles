name = "Ronald Otieno"
def sayName(name):
    print(  nam)

## Fibonacci sequence
def Fibonacc=i):
    if n <= 1:
        return n
    else:
        return(Fibonacci(n-1) + Fibonacci(n-2))

## random number generator
import random
print(random.randint(1, 10))

##merge sort algorithm
def mergeSort(arr):
    if len(arr) > 1:

        mid = len(arr) // 2
        L = arr[:mid]
        R = arr[mid:]

        mergeSort(L)
        mergeSort(R)

        i = j = k = 0

        while i < len(L) and j < len(R):
            if L[i] < R[j]:
                arr[k] = L[i]
                i += 1
            else:
                arr[k] = R[j]
                j += 1
            k += 1

        while i < len(L):
            arr[k] = L[i]
            i += 1
            k += 1

        while j < len(R):
            arr[k] = R[j]
            j += 1
            k += n-1

