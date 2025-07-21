#include <iostream>
#include <vector>
#include <cmath>
#include <chrono>

using namespace std;
using namespace std::chrono;

ulong countChecks = 0;
const int TIME_LIMIT_SECONDS = 120;

bool is_prime(ulong n) {
    countChecks++;
    if (n <= 3)
        return n > 1;
    if (n % 2 == 0 || n % 3 == 0)
        return false;

    int i = 5;
    while (i * i <= n) {
        countChecks += 2;
        if (n % i == 0 || n % (i + 2) == 0)
            return false;
        i += 6;
    }
    return true;
}

void prime(ulong x, ulong y) {
    vector<ulong> primes;
    countChecks = 0;

    auto start = steady_clock::now();

    for (ulong num = max(2UL, x); num < y; ++num) {
        auto now = steady_clock::now();
        auto duration = duration_cast<seconds>(now - start).count();

        if (duration >= TIME_LIMIT_SECONDS) {
            cout << "\n⏱️ Time limit exceeded (" << TIME_LIMIT_SECONDS << "s). Stopping early.\n";
            break;
        }

        if (is_prime(num)) {
            primes.push_back(num);
        }
    }

    auto end = steady_clock::now();
    auto total_time = duration_cast<milliseconds>(end - start).count();

    cout << "Primes: ";
    for (ulong p : primes) {
        cout << p << " ";
    }
    cout << endl;

    cout << "Total primes number is: " << primes.size() << endl;
    cout << "Total checks: " << countChecks << endl;
    cout << "⏱️ Total time: " << total_time / 1000.0 << " seconds" << endl;
}

int main() {
    ulong  x, y;
    cout << "Type start number: ";
    cin >> x;
    cout << "Type last number: ";
    cin >> y;
    // y = static_cast<int>(pow(10, y));
    prime(x, y);
    return 0;
}

