//
//  EulerMaths.swift
//  EulerSwift
//
//  Created by Joseph Walden on 13/03/2021.
//

import Foundation

class BigNumber {
    enum BigNumberError: Error {
        case InvalidDigit
    }
    internal init (number: String) throws {
        self.number = []
        for i in number.reversed() {
            if let i = Int(String(i)) {
                self.number.append(i)
            }
            else {
                throw BigNumberError.InvalidDigit
            }
        }
    }
    public func toString() -> String {
        var str = ""
        for i in number.reversed() {
            str += String(i)
        }
        return str
    }
    public static func postadd(number:BigNumber) {
        var index = 0
        while index != number.number.count {
            while number.number[index] > 9 {
                if number.number.count < index + 2 {
                    number.number.append(1)
                }
                else {
                    number.number[index + 1] += 1
                }
                number.number[index] -= 10
            }
            index += 1
        }
    }
    
    public static func +(left:BigNumber, right:Int) -> BigNumber {
        left.number[0] += right
        postadd(number: left)
        return left
    }
    public static func +(left:BigNumber, right:BigNumber) -> BigNumber {
        var index = 0
        while index < left.number.count {
            if right.number.count > index {
                right.number[index] += left.number[index]
            }
            else {
                right.number.append(left.number[index])
            }
            index += 1
        }
        postadd(number: right)
        return right
    }
    
    public static func *(left:BigNumber, right:Int) -> BigNumber {
        for i in 0 ..< left.number.count {
            left.number[i] *= right
        }
        postadd(number: left)
        return left
    }
    
    public static func ==(left:BigNumber, right:BigNumber) -> Bool {
        return left.number == right.number
    }
    public static func test() -> Bool {
        do {
            let addition_test = try BigNumber(number: "100") + BigNumber(number: "50")
            let multiplication_test = try BigNumber(number: "50") * 5
            return try addition_test == BigNumber(number: "150") &&
            multiplication_test == BigNumber(number: "250")
        }
        catch {
            return false
        }
    }
    
    var number:[Int]
}

class EulerMaths {
    static func triangle(n:Int) -> Int {
        var result = 0
        for i in 1 ... n {
            result += i
        }
        return result
    }
    static func divisible(byArray arr:[Int], n:Int) -> Bool {
        for i in arr {
            if n % i != 0 {
                return false
            }
        }
        return true
    }
    static func sum(of array:[Int]) -> Int {
        var s = 0
        for i in array {
            s += i
        }
        return s
    }
    static func isPalindrome(n:Int) -> Bool {
        let s = String(n)
        if s == String(s.reversed()) {
            return true
        }
        return false
    }
    static func primes(n:Int) -> [Int] {
        var sieve:[Bool] = Array(repeating: true, count: n + 1)
        var returnVal:[Int] = []
        sieve[0] = false
        sieve[1] = false
        var index = 2
        while (index <= n) {
            if sieve[index] {
                returnVal.append(index)
                var index2 = 2 * index
                while (index2 <= n) {
                    sieve[index2] = false
                    index2 += index
                }
            }
            index += 1
        }
        return returnVal
    }
    static func primeFactors(n:Int, primes p:[Int]? = nil) -> [Int] {
        let p = p ?? primes(n: Int(sqrt(Double(n))) + 1)
        var factors:[Int] = []
        for i in p {
            if i > n / 2 {
                break
            }
            if n % i == 0 {
                factors.append(i)
            }
        }
        return factors
    }
    static var factorCache:Dictionary<Int, [Int]> = [:]
    static func factors(n:Int, primes p:[Int]? = nil, usePrimes:Bool = true) -> [Int] {
        if factorCache.keys.contains(n) {
            return factorCache[n]!
        }
        var f:Set<Int> = [1, n]
        if usePrimes {
            for i in primeFactors(n: n, primes: p) {
                f.update(with: i)
                if n % i == 0 && n != i {
                    f.update(with: n / i)
                    for j in factors(n: n/i, primes: p) {
                        f.update(with: j)
                    }
                }
            }
        }
        else {
            for i in 1 ... (n / 2) + 1 {
                if n % i == 0 {
                    f.update(with: i)
                }
            }
        }
        let array = Array(f).sorted()
        factorCache.updateValue(array, forKey: n)
        return array
    }
    static func fibonacci(max:Int) -> [Int] {
        var numbers:[Int] = [1, 1]
        var a = 1, b = 1
        while (b <= max) {
            let temp = b
            b += a
            a = temp
            numbers.append(b)
        }
        return numbers
    }
    static func collatz(start:Int) -> [Int] {
        var sequence:[Int] = [start]
        var current = start
        while current != 1 {
            if current & 1 == 0 {
                current /= 2
            }
            else {
                current *= 3
                current += 1
            }
            sequence.append(current)
        }
        return sequence
    }
    static func collatzLength(start:Int) -> Int {
        var length:Int = 1
        var current = start
        while current != 1 {
            if current & 1 == 0 {
                current /= 2
            }
            else {
                current *= 3
                current += 1
            }
            length += 1
        }
        return length
    }
}
