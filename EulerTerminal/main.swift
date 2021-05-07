//
//  main.swift
//  EulerTerminal
//
//  Created by Joseph Walden on 07/05/2021.
//

import Foundation
import ArgumentParser

struct Euler : ParsableCommand {
    @Argument(help: ArgumentHelp("Problem Number", discussion: "The problem to run", shouldDisplay: true))
    var problem:Int?
    
    mutating func run() throws {
        if let num = problem {
            let p = Problems.problems.first(where: {
                x in
                x.0[0] == "Problem \(num)"
            })
            if let problem = p {
                print(problem.1())
            } else {
                print("Invalid Problem")
            }
        }
        else {
            print("For more information type EulerTerminal --help ")
            for i in Problems.problems {
                print("\(i.0[0]) - \(i.0[1])")
            }
        }
    }
}

Euler.main()

