from sympy import factorint

def to_superscript(exp: int) -> str:
    """Convert small exponents to Unicode superscript."""
    superscripts = ["", "¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹"]
    if 1 <= exp <= 9:
        return superscripts[exp]
    return f"^{exp}"


def prime_factorize(n: int) -> str:
    factors = factorint(n)
    parts = [f"{base}{to_superscript(exp)}" for base, exp in factors.items()]
    return f"Prime factorization of {n} is:\n{' * '.join(parts)}"


def main():
    try:
        num_str = input("Enter a large integer (≥ 2): ").strip().replace(",", "").replace(".", "")
        n = int(num_str)
        if n < 2:
            print("Please enter an integer ≥ 2.")
            return
        print("Processing... (this may take time for large numbers)")
        result = prime_factorize(n)
        print(result)
    except ValueError:
        print("Invalid input. Please enter a valid integer.")


if __name__ == "__main__":
    main()

