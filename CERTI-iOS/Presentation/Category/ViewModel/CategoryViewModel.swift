//
//  CategoryViewModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/8/25.
//

import Foundation

import os

enum CategoryViewRoute {
    case navigateToSearch
    case navigateToCertificateDetail
    
    case categoryViewRoutePop
}

@MainActor
final class CategoryViewModel: ObservableObject {
    @Published var categoryViewRoute: CategoryViewRoute?
    @Published var licenseCards: [LicenseCardModel] = []
    @Published var searchLicenseCards: [LicenseCardModel] = []
    @Published var isFilterToggle = false
    @Published var selectedCategory: JobCategory = .business
    @Published var inputText: String = ""
    @Published var searchResult: SearchResultType? = nil
    @Published var selectedCertificateId: Int = 0

    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "Certification")
    
    var trimmedInput: String {
        inputText.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private let fetchCategoryUseCase: FetchCategoryUseCase
    private let switchFavoriteUseCase: SwitchFavoriteUseCase
    private let searchCertificationUseCase: SearchCertificationUseCase
    
    init(
        fetchCategoryUseCase: FetchCategoryUseCase,
        switchFavoriteUseCase: SwitchFavoriteUseCase,
        searchCertificationUseCase: SearchCertificationUseCase
    ) {
        self.fetchCategoryUseCase = fetchCategoryUseCase
        self.switchFavoriteUseCase = switchFavoriteUseCase
        self.searchCertificationUseCase = searchCertificationUseCase
    }
}


// MARK: - Navigation Func

extension CategoryViewModel {
    
    func navigateToSearch() {
        categoryViewRoute = .navigateToSearch
    }
    
    func navigateToCertificateDetail() {
        categoryViewRoute = .navigateToCertificateDetail
    }
    
    func categoryViewRoutePop() {
        categoryViewRoute = .categoryViewRoutePop
    }
}


// MARK: - Network

extension CategoryViewModel {
    func getCategoryList() async {
        let result = await fetchCategoryUseCase.execute(isFavorite: isFilterToggle, jobs: selectedCategory.description)
        
        switch result {
        case .success(let response):
            
            self.licenseCards.removeAll()
            self.licenseCards = response.toLicenseCardModelList()
            logger.debug("✅ getCategoryList success: \(response.toLicenseCardModelList())")
            
        case .failure(let error):
            logger.error("getCategoryList failed: \(error.localizedDescription)")
        }
    }
    
    func postFavorite(certificationId: Int) async {
        let result = await switchFavoriteUseCase.execute(id: certificationId)
        
        switch result {
        case .success(_):
            logger.debug("✅ toggleFavorite success")
            
        case .failure(let error):
            logger.error("toggleFavorite failed: \(error.localizedDescription)")
        }
    }
    
    func searchCertifiedList(keyword: String) async {
        let result = await searchCertificationUseCase.execute(keyword: keyword)
        
        switch result {
        case .success(let response):
            self.searchLicenseCards.removeAll()
            self.searchLicenseCards = response.toLicenseCardModelList()
            logger.debug("✅ searchCertifiedList success: \(response.toLicenseCardModelList())")
            
        case .failure(let error):
            logger.error("searchCertifiedList failed: \(error.localizedDescription)")
        }
    }
}


// MARK: - Func

extension CategoryViewModel {
    func toggleFavorite(id: Int) {
        guard let index = licenseCards.firstIndex(where: { $0.id == id }) else { return }
        licenseCards[index].isFavorite.toggle()
    }
    
    func toggleSearchFavorite(id: Int) {
        guard let index = searchLicenseCards.firstIndex(where: { $0.id == id }) else { return }
        searchLicenseCards[index].isFavorite.toggle()
    }
    
    func selectCertificate(id: Int) {
        selectedCertificateId = id
    }
}
