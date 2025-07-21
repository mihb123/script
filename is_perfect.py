#!/usr/bin/env python3

from sympy import divisors
from time import time

def is_perfect(n):
    if n <= 1:
        return False
    proper_divs = divisors(n)[:-1]  # loại chính nó
    return sum(proper_divs) == n

if __name__ == "__main__":
    raw_input = input("Nhập số cần kiểm tra: ").strip()

    # Loại bỏ dấu phẩy hoặc chấm phân cách nhóm số
    cleaned_input = raw_input.replace(",", "").replace(".", "")

    try:
        n = int(cleaned_input)
        if len(cleaned_input) > 100:
            print(f"(🔢 Số có {len(cleaned_input)} chữ số)")
        start = time()
        if is_perfect(n):
            print(f"✅ {n:,} là số hoàn hảo.")
        else:
            print(f"❌ {n:,} không phải số hoàn hảo.")
        print(f"⏱ Thời gian kiểm tra: {round(time() - start, 4)} giây")
    except ValueError:
        print("❗ Vui lòng nhập số nguyên hợp lệ.")

