//
//  ElementsListView.swift
//  lab5
//
//  Created by UrdenVM on 25.02.2026.
//
import SwiftUI

struct ElementsListView: View {
    @EnvironmentObject var viewModel: listViewModel
    @State var showAlert = false
    @State var errorType:NetworkErrors? = nil
    var someElements:[ElementData]? = nil
    @State var errorMessage:String = ""
    
    var body: some View {
        NavigationSplitView {
            ScrollView {
                LazyVStack(alignment: .leading){
                    ForEach(viewModel.someElements ?? [], id: \.self) { currentElement in
                        NavigationLink {
                            ElementDetailView(element: currentElement)
                        } label: {
                            ElementRowView(element: currentElement)
                        }
                        Divider()
                    }
                }
                .navigationTitle("Dnd spell list")
                
            }.padding([.horizontal], 10)
        }
        detail: {
            Text("Select an item")
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("An error occured while executing request"),
                message: Text(errorType?.errorText() ?? "Unkhown Error"),
                dismissButton: .destructive(Text("Close")){
                    showAlert = false
                    errorType = nil
                })
        }
        .task {
            do {
                try await viewModel.getElements()
            } catch NetworkErrors.serverError(let statusCode){
                errorType = NetworkErrors.serverError(statusCode: statusCode)
                showAlert = true
            } catch NetworkErrors.invalidData{
                errorType = NetworkErrors.invalidData
                showAlert = true
            } catch {
                errorType = NetworkErrors.someError
                showAlert = true
            }
        }
    }
    
    
}


