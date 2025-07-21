#!/usr/bin/python3

import time
from sympy import isprime

TIME_LIMIT = 60  # giây
count = 0

def prime(x, y):
    global count
    count = 0
    primes = []

    start_time = time.time()

    for num in range(max(2, x), y):
        elapsed = time.time() - start_time
        if elapsed >= TIME_LIMIT:
            print(f"\n⏱️ Time limit exceeded ({TIME_LIMIT}s). Stopping early.")
            break

        if isprime(num):
            primes.append(num)
            count += 1  # Đếm số nguyên tố

    total_time = time.time() - start_time

    print("Primes:", primes)
    print("Total primes found:", len(primes))
    print("Total checks:", count)
    print(f"Total time: {total_time:.3f} seconds")

if __name__ == "__main__":
    x = int(input("Type start number: "))
    y = int(input("Type last number: "))
    
    prime(x, y)

