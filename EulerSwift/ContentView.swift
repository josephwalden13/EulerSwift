//
//  ContentView.swift
//  EulerSwift
//
//  Created by Joseph Walden on 11/03/2021.
//

import SwiftUI

struct Problems {
    public static var problems:[([String], () -> String)] = [
        (["Problem 1", "Find the sum of all the multiples of 3 or 5 below 1000."], problem001),
        (["Problem 2", "By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms."], problem002),
        (["Problem 3", "What is the largest prime factor of the number 600851475143?"], problem003),
        (["Problem 4", "Find the largest palindrome made from the product of two 3-digit numbers."], problem004),
        (["Problem 5", "What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?"], problem005),
        (["Problem 6", "Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum."], problem006),
        (["Problem 7", "What is the 10001st prime number?"], problem007),
        (["Problem 8", "Find the thirteen adjacent digits in the 1000-digit number that have the greatest product. What is the value of this product?"], problem008),
        (["Problem 9", "There exists exactly one Pythagorean triplet for which a + b + c = 1000.\nFind the product abc."], problem009),
        (["Problem 10", "Find the sum of all the primes below two million."], problem010)
    ]
    static func problem001() -> String {
        var index = 3;
        var sum = 0;
        while (index < 1000) {
            if (index % 3 == 0 || index % 5 == 0) {
                sum += index
            }
            index += 1
        }
        return String(sum)
    }
    static func problem002() -> String {
        var sum:Int = 0
        for i in fibonacci(max: 4000000) {
            if i % 2 == 0 {
                sum += i
            }
        }
        return String(sum)
    }
    static func problem003() -> String {
        let factors = primeFactors(n: 600851475143)
        return String(factors.last!)
    }
    static func problem004() -> String {
        var largest:Int = 0
        for i in 900 ..< 1000 {
            for j in 900 ..< 1000 {
                let product = i * j
                if isPalindrome(n: product) {
                    if product > largest {
                        largest = product
                    }
                }
            }
        }
        return String(largest)
    }
    static func problem005() -> String {
        var index = 11 * 13 * 17 * 19 * 20 //use 20 * primes (11 <= x <= 19)
        let numbers:[Int] = [20, 19, 18, 17, 16, 15, 14, 13, 12, 11] //only needs to check 11-20 to save time
        while !divisible(byArray: numbers, n: index) {
            index += 11 * 13 * 17 * 19 * 20 //use 20 * primes (11 <= x <= 19)
        }
        return String(index)
    }
    static func problem006() -> String {
        var sum:Int = 0
        var sumSquares:Int = 0
        for i in 1...100 {
            sum += i
            sumSquares += Int(pow(Double(i), 2))
        }
        let diff = Int(pow(Double(sum), 2)) - sumSquares
        return String(diff)
    }
    static func problem007() -> String {
        let p = primes(n: 1000000) //assuming the 10001st prime is less than 1e6
        return String(p[10000])
    }
    static func problem008() -> String {
        let massiveNumber:String = "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450"
        if massiveNumber.count != 1000 {
            return "I think you typo'd the number :("
        }
        var largestProduct = 0
        for i in 0 ... 1000 - 13 {
            var tempProduct = 1
            for j in i ..< i + 13 {
                let strIndex = massiveNumber.index(massiveNumber.startIndex, offsetBy: j)
                let c = massiveNumber[strIndex]
                let n = c.wholeNumberValue!
                tempProduct *= n
            }
            if tempProduct > largestProduct {
                largestProduct = tempProduct
            }
        }
        return String(largestProduct)
    }
    static func problem009() -> String {
        for a in 200 ... 500 {
            for b in 200 ... 500 {
                for c in 200 ... 500 { //best guess at a reasonable range
                    if a > b || b > c { // a < b < c
                        continue
                    }
                    if (a * a + b * b == c * c) {
                        //triplet
                        if (a + b + c == 1000) {
                            return String(a * b * c)
                        }
                    }
                }
            }
        }
        return "Failed to find"
    }
    static func problem010() -> String {
        return String(sum(of: primes(n: 2000000)))
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
    
    static func primeFactors(n:Int) -> [Int] {
        let p = primes(n: Int(sqrt(Double(n))) + 1)
        var factors:[Int] = []
        for i in p {
            if n % i == 0 {
                factors.append(i)
            }
        }
        return factors
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
}

struct AllView: View {
    @State var showResult:Bool = false
    @State var result:String = ""
    var body: some View {
        Form {
            ForEach (Problems.problems, id: \.0) {
                x in
                DisclosureGroup(
                    content: { Text(x.0[1]) },
                    label: { Button(x.0[0]) {
                        let start = DispatchTime.now()
                        let answer = x.1()
                        let end = DispatchTime.now()
                        let timeInterval = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1e6 //ms
                        result = String(format: "\(answer) - Took %.3fms", timeInterval)
                        showResult = true;
                    } })
                
            }.alert(isPresented: $showResult, content: {
                Alert(title: Text(result))
            })
        }
    }
}

struct SlowView: View {
    @State var showResult:Bool = false
    @State var result:String = ""
    @State var problems:[([String], () -> String)] = []
    var body: some View {
        Form {
            Text("May take some time to start displaying problems. Displaying problems which take over 250ms to compute")
            ForEach (problems, id: \.0) {
                x in
                DisclosureGroup(
                    content: { Text(x.0[1]) },
                    label: { Button(x.0[0]) {
                        let start = DispatchTime.now()
                        let answer = x.1()
                        let end = DispatchTime.now()
                        let timeInterval = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1e6 //ms
                        result = String(format: "\(answer) - Took %.3fms", timeInterval)
                        showResult = true;
                    } })
                
            }.alert(isPresented: $showResult, content: {
                Alert(title: Text(result))
            })
        }.onAppear {
            problems = []
            DispatchQueue.main.async {
            for i in Problems.problems {
                    let start = DispatchTime.now()
                    _ = i.1()
                    let end = DispatchTime.now()
                    let timeInterval = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1e6 //ms
                    if timeInterval > 250 {
                        problems.append(i)
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                AllView().tabItem { Label("All Problems", systemImage: "house") }
                SlowView().tabItem { Label("Slow Problems", systemImage: "tortoise")}
            }.navigationTitle("Project Eueler")
        }
    }
}
