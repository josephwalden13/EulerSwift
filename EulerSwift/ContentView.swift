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
        (["Problem 7", "What is the 10 001st prime number?"], problem007)
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
        var index = 19 * 20 //use 19 * 20 as a starting point since it has to be divisible by both
        var numbers:[Int] = []
        for i in 1...20 {
            numbers.append(i)
        }
        while !divisible(byArray: numbers, n: index) {
            index += 20 //Has to be a multiple of 20
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
    
    static func divisible(byArray arr:[Int], n:Int) -> Bool {
        for i in arr {
            if n % i != 0 {
                return false
            }
        }
        return true
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
            Text("May take some time to start displaying problems")
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
                    if timeInterval > 999 {
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
