//
//  ContentView.swift
//  EulerSwift
//
//  Created by Joseph Walden on 11/03/2021.
//

import SwiftUI

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
