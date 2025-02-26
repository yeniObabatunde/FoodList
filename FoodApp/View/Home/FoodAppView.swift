//
//  FoodAppView.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import SwiftUI

struct FoodAppView: View {
    @State private var searchText: String = ""
    @State private var selectedCategory: FoodCategory = .all
    @StateObject private var viewModel: FoodListViewModel
    @State private var navigationPath = NavigationPath()
    
    init(viewModel: FoodListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 0) {
                HeaderView()
                
                SearchBarView(searchText: $viewModel.searchText)
                    .padding(.horizontal)
                    .padding(.top, 8)
                
                CategoryFilterView(selectedCategory: $selectedCategory)
                    .padding(.top, 16)
                
                SectionTitleView(title: "All Foods")
                    .padding(.horizontal)
                    .padding(.top, 16)
             
                if viewModel.isLoading && viewModel.foodList.isEmpty {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if !viewModel.searchText.isEmpty && viewModel.filteredFoodList.isEmpty {
                    Text("Food not found on the list!")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                else {
                    List {
                        ForEach(viewModel.filteredFoodList) { food in
                            FoodItemView(food: food)
                                .listRowSeparator(.hidden)
                                .onTapGesture {
                                    navigationPath.append(food)
                                }
                        }
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(PlainListStyle())
                    .refreshable {
                        await Task { viewModel.loadFoodList() }.value
                    }
                    .onAppear {
                        viewModel.loadFoodList()
                    }
                }
                
                Spacer()
            }
            .navigationDestination(for: FoodModelDatum.self) { food in
                FoodDetailsViewRepresentable(food: food)
                    .ignoresSafeArea(.container, edges: .top)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}
