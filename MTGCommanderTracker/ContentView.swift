import SwiftUI

struct ContentView: View {
    @AppStorage("counters") private var countersData: Data = Data()
    @State private var counters: [Counter] = []
    @State private var newCounterTitle: String = ""
    @State private var newCounterValue: String = ""
    @State private var showingAddCounter = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    List {
                        ForEach(counters.indices, id: \.self) { index in
                            CounterView(counter: Binding(
                                get: { self.counters[index] },
                                set: { newValue in
                                    self.counters[index] = newValue
                                    if let encoded = try? JSONEncoder().encode(self.counters) {
                                        countersData = encoded
                                    }
                                }
                            ))
                        }
                        .onDelete(perform: removeCounter)
                    }
                    .listStyle(PlainListStyle())
                    
                    Button(action: { showingAddCounter.toggle() }) {
                        Text("Add Counter")
                            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 48)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(6)
                    }
                    .padding(.horizontal, geometry.size.width * 0.05)
                }
                .navigationTitle("Tracker")
                .sheet(isPresented: $showingAddCounter, content: {
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
                                if let encoded = try? JSONEncoder().encode(self.counters) {
                                    countersData = encoded
                                }
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
                })
            }
        }.onAppear(perform: {
            if let decoded = try? JSONDecoder().decode([Counter].self, from: countersData) {
                self.counters = decoded
            }
        })
    }
    
    func removeCounter(at offsets: IndexSet) {
        counters.remove(atOffsets: offsets)
        if let encoded = try? JSONEncoder().encode(self.counters) {
            countersData = encoded
        }
    }
}
