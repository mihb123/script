#!/usr/bin/env python3

def pow():
    a = input("Nhập số mũ: ")
    b = input("Nhập số: ")
    p  = float(b) ** float(a)
    p = round(p, 4)
    print(f"Kết quả {b}^{a} là: {p}")

pow()
