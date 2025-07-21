#! /usr/bin/env python3
import subprocess
def calculate(a, b):
    if a%b !=0:
        print(f"{a} không chia hết cho {b}")
        return
    if a<b:
        return 0
    return a + calculate(a-b,b)

def call():
    last = input("Last number in array: ")
    step = input("Step of each number: ")
    sum = calculate(int(last), int(step))
    if sum != None:
        print(f"Tổng tất cả là {sum}")
call()

