#!/usr/bin/env python3

import sys

def root_pow():
    print("Đây là chương trình tính căn bậc n của số a")
    a = float(input("Nhập n: "))
    b = float(eval(input("Nhập a: ")))

    root = b ** (1 / a)
    root = round(root,3)
    print("The result is", root)
    
root_pow()
