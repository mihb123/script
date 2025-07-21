#!/usr/bin/env python3

import sys
sys.set_int_max_str_digits(0)

from sympy import isprime, sympify
from time import time

def check_prime():
    raw_input = input("Nhập số hoặc biểu thức cần kiểm tra (vd: 2^44497 - 1): ").strip()
    cleaned_input = raw_input.replace(",", "").replace(" ", "").replace("^", "**").replace(".", "")

    try:
        # Dùng sympify để parse biểu thức an toàn và hỗ trợ số lớn
        n = sympify(cleaned_input)

        if not n.is_Integer:
            print("❗ Biểu thức phải cho ra số nguyên.")
            return

        if n <= 1:
            print("❌ Số phải lớn hơn 1 để kiểm tra nguyên tố.")
            return

        num_digits = len(str(n))
        print(n)
        print(f"(🔢 Số này có {num_digits:,} chữ số) đang kiểm tra ...")

        start = time()
        if isprime(n):
            print(f"✅ là số nguyên tố.")
        else:
            print(f"❌ {n} không phải số nguyên tố.")
        print(f"⏱ Thời gian kiểm tra: {round(time() - start, 4)} giây")

    except Exception as e:
        print(f"❗ Lỗi: {e}")

if __name__ == "__main__":
    check_prime()

