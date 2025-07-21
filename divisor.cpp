#include <iostream>
#include <string>
#include <vector>

using namespace std;

// Convert exponent to Unicode superscript
string toSuperscript(int exp) {
    string superscripts[] = {"", "¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹"};
    if (exp >= 1 && exp <= 9) return superscripts[exp];
    return "^" + to_string(exp);
}

// Convert __int128 to string for output
string int128ToString(__int128_t n) {
    if (n == 0) return "0";
    string result;
    bool neg = false;
    if (n < 0) {
        neg = true;
        n = -n;
    }
    while (n > 0) {
        result = char('0' + (n % 10)) + result;
        n /= 10;
    }
    return neg ? "-" + result : result;
}

// Input __int128 from string
__int128_t stringToInt128(const string& s) {
    __int128_t result = 0;
    for (char c : s) {
        if (c >= '0' && c <= '9') {
            result = result * 10 + (c - '0');
        }
    }
    return result;
}

int main() {
    string input;
    cout << "Enter a number (up to ~39 digits): ";
    cin >> input;

    __int128_t n = stringToInt128(input);
    __int128_t original = n;

    cout << "Prime factorization of " << int128ToString(original) << " is: ";

    bool first = true;
    for (__int128_t i = 2; i * i <= n; ++i) {
        int count = 0;
        while (n % i == 0) {
            n /= i;
            count++;
        }
        if (count > 0) {
            if (!first) cout << " * ";
            cout << int128ToString(i) << toSuperscript(count);
            first = false;
        }
    }

    if (n > 1) {
        if (!first) cout << " * ";
        cout << int128ToString(n) << toSuperscript(1);
    }

    cout << endl;
    return 0;
}

