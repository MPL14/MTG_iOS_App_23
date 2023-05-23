import SwiftUI

struct ContentView: View {
    @State private var counters: [Counter] = []
    @State private var newCounterTitle: String = ""
    @State private var newCounterValue: String = ""
    @State private var showingAddCounter = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(counters.indices, id: \.self) { index in
                        CounterView(counter: $counters[index])
                    }
                    .onDelete(perform: removeCounter)
                }
                .listStyle(PlainListStyle())
                
                Button(action: { showingAddCounter.toggle() }) {
                    Text("Add Counter")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .navigationTitle("Tracker")
            .sheet(isPresented: $showingAddCounter, content: {
                GeometryReader { geometry in
                    VStack {
                        Text("Add a new counter")
                            .font(.headline)
                            .padding()
                        
                        TextField("Title", text: $newCounterTitle)
                            .padding(.vertical)
                            .padding(.horizontal, 24)
                            .background(
                                Color(UIColor.systemGray6)
                            )
                            .clipShape(Capsule(style: .continuous))
                        
                        TextField("Initial value", text: $newCounterValue)
                        
                            .keyboardType(.numberPad)
                            .padding(.vertical)
                            .padding(.horizontal, 24)
                            .background(
                                Color(UIColor.systemGray6)
                            )
                            .clipShape(Capsule(style: .continuous))
                        
                        Button(action: {
                            if let intValue = Int(newCounterValue) {
                                let newCounter = Counter(title: newCounterTitle, value: intValue)
                                counters.append(newCounter)
                                newCounterTitle = ""
                                newCounterValue = ""
                                showingAddCounter.toggle()
                            }
                        }) {
                            Text("Add")
                                .padding()
                                .frame(width: geometry.size.width * 0.85) // Adjust the width based on the parent view
                                .background(Color.green)
                                .foregroundColor(.white)
                            
                                .clipShape(Capsule(style: .continuous))
                        }
                    }
                    .padding(.top, 136)
                    .padding()
                    
                }
            })
        }
    }
    
    func removeCounter(at offsets: IndexSet) {
        counters.remove(atOffsets: offsets)
        
    }
    
}
