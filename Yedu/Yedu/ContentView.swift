//
//  ContentView.swift
//  Yedu
//
//  Created by TrαΊ§n T. DΕ©ng  on 23/06/2022.
//

import SwiftUI
import CoreData

enum SearchScope: String, CaseIterable {
    case name, company
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State var search = ""  // π Search text value
    @State private var searchScope = SearchScope.name   // π Search category value
    
    //       π€ Users data (from ViewModel)
    //                     |
    //           --------------------
    @StateObject var vm = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    if vm.isRefreshing {
                        ProgressView()
                    } else {
                        List {
                            //   π¨βπ¨βπ¦βπ¦ User IDs in ViewModel
                            //              |
                            //      ------------------
                            ForEach(vm.users, id: \.id) { user in
                                Section {
                                    CardView(user: user)
                                        .listRowSeparator(.hidden)
                                    //                  π Allow swipe all to left to delete
                                    //                                  |
                                    //                --------------------------------------
                                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                            Button(role: .destructive){
                                                
                                            } label: {
                                                //                    π Delete symbol
                                                //                            |
                                                //                     ---------------
                                                Label("", systemImage: "trash.circle")
                                            }
                                            .tint(.pink)
                                        }
                                }
                            }
                        }
                        //           π Search string     π Category           π Placeholder text
                        //                   |                 |                          |
                        //                -------         ------------          --------------------
                        .searchable(text: $search, scope: $searchScope, prompt: "Look for a user...") {
                            ForEach(SearchScope.allCases, id: \.self) { scope in
                                Text(scope.rawValue.capitalized)
                            }
                        }
                        .onChange(of: search) { searchValue in
                            switch (searchScope) {
                            case .name:
                                //                              π Search by Name
                                //                                      |
                                //                         ---------------------------
                                vm.users = vm.users.filter { $0.name.contains(search)}
                            case .company:
                                //                                π Search by company
                                //                                         |
                                //                         -----------------------------------
                                vm.users = vm.users.filter { $0.company.name.contains(search)}
                            }
                            
                            if search.isEmpty {
                                vm.fetchUsers()
                            }
                        }
                        .shadow(radius: 25)
                        .listStyle(InsetGroupedListStyle())
                        .navigationTitle(Text("Users"))
                    }
                }
                .navigationTitle("Users")
                .navigationBarItems(trailing: HStack {
                    NavigationLink(destination: AddView(), label: {
                        
                        //                  β plus symbol
                        //                         |
                        //                -------------------
                        Image(systemName: "plus.square.fill")
                            .font(.largeTitle)
                        
                    })
                })
                .onAppear(perform: vm.fetchUsers)
                .alert(isPresented: $vm.hasError,
                       error: vm.error) {
                    Button(action: vm.fetchUsers) {
                        Text("Retry")   // π Retry fetching alert
                    }
                }
            }
        }
    }
    
    private func addUser() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteUser(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
#endif
