from sympy import divisors
from time import time

def list_proper_divisors():
    raw_input = input("Nhập số cần liệt kê ước: ").strip()
    cleaned_input = raw_input.replace(",", "").replace(".", "")

    try:
        n = int(cleaned_input)
        if n <= 1:
            print("❗ Vui lòng nhập số nguyên lớn hơn 1.")
            return

        print(f"(🔢 Số có {len(cleaned_input)} chữ số)")
        start = time()

        all_divs = divisors(n)
        proper_divs = [d for d in all_divs if d != 1 and d != n]

        print(f"Ước số của {n:,}:")
        if proper_divs:
            print(", ".join(map(str, proper_divs)))
        else:
            print("✅ Không có ước thực sự nào (đây là số nguyên tố).")

        print(f"🔢 Tổng cộng {len(proper_divs)} ước số.")
        print(f"⏱ Thời gian xử lý: {round(time() - start, 4)} giây")
    except ValueError:
        print("❗ Vui lòng nhập số nguyên hợp lệ.")
if __name__ == "__main__":
    list_proper_divisors()

