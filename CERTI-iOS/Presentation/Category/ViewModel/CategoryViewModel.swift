//
//  CategoryViewModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/8/25.
//

import Foundation

import os

@MainActor
class CategoryViewModel: ObservableObject {
    
    @Published var licenseCards: [LicenseCardModel] = []
    @Published var searchLicenseCards: [LicenseCardModel] = []
    @Published var isFilterToggle = false
    @Published var selectedCategory: JobCategory = .business
    @Published var inputText: String = ""
    @Published var searchResult: SearchResultType? = nil
    @Published var selectedCertificateId: Int = 0
    
    private let categoryService = AppDIContainer.shared.makeCertificationRepository()
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "Certification")
    
    func toggleFavorite(id: Int) {
        guard let index = licenseCards.firstIndex(where: { $0.id == id }) else { return }
        licenseCards[index].isFavorite.toggle()
    }
    
    func toggleSearchFavorite(id: Int) {
        guard let index = searchLicenseCards.firstIndex(where: { $0.id == id }) else { return }
        searchLicenseCards[index].isFavorite.toggle()
    }
    
    var trimmedInput: String {
        inputText.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func selectCertificate(id: Int) {
        selectedCertificateId = id
    }
}


// MARK: - Network

extension CategoryViewModel {
    func getCategoryList() async {
        let result = await categoryService.getCategory(isFavorite: isFilterToggle, jobs: selectedCategory.description)
        
        switch result {
        case .success(let response):
            guard let data = response.data else {
                logger.error("❌ getCategoryList: No data received")
                return
            }
            
            self.licenseCards.removeAll()
            self.licenseCards = data.certificationSimpleList
            logger.debug("✅ getCategoryList success: \(data.certificationSimpleList)")
            
        case .failure(let error):
            logger.error("getCategoryList failed: \(error.localizedDescription)")
        }
    }
    
    func postFavorite(certificationId: Int) async {
        let result = await categoryService.switchFavorite(certificationId: certificationId)
        
        switch result {
        case .success(_):
            logger.debug("✅ toggleFavorite success")
            
        case .failure(let error):
            logger.error("toggleFavorite failed: \(error.localizedDescription)")
        }
    }
    
    func searchCertifiedList(keyword: String) async {
        let result = await categoryService.searchCertification(keyword: keyword)
        
        switch result {
        case .success(let response):
            guard let data = response.data else {
                logger.error("❌ searchCertifiedList: No data received")
                return
            }
            
            self.searchLicenseCards.removeAll()
            self.searchLicenseCards = data.certificationSimpleList
            logger.debug("✅ searchCertifiedList success: \(data.certificationSimpleList)")
            
        case .failure(let error):
            logger.error("searchCertifiedList failed: \(error.localizedDescription)")
        }
    }
}
