//
//  ContentView.swift
//  guess-the-flag
//
//  Created by Phattarapong Yodwiset on 1/10/2568 BE.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    @State private var score = 0
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400).ignoresSafeArea()
            
            VStack {
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Text("Guess the Flag")
                       .font(.largeTitle.weight(.bold))
                       .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of").font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer]).font(.largeTitle.weight(.semibold)).foregroundStyle(.secondary)
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Text(flag(country: countries[number]))
                                .font(.system(size: 80))
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                                .padding()
                        }
                    }
                }.frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
            }
        }.alert(scoreTitle, isPresented: $showingScore, actions: {
            Button("Continue", action: askQuestion)
        }, message: {
            Text("Your score is \(score)")
        }).safeAreaPadding()
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            score = max(0, score - 1)
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flag(country: String) -> String {
        let countryToFlag: [String: String] = [
            "Estonia": "🇪🇪",
            "France": "🇫🇷",
            "Germany": "🇩🇪",
            "Ireland": "🇮🇪",
            "Italy": "🇮🇹",
            "Nigeria": "🇳🇬",
            "Poland": "🇵🇱",
            "Spain": "🇪🇸",
            "UK": "🇬🇧",
            "Ukraine": "🇺🇦",
            "US": "🇺🇸"
        ]
        return countryToFlag[country] ?? "🏴"
    }
}

#Preview {
    ContentView()
}
