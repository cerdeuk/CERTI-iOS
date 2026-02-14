//
//  UploadImageToPresignedURLUseCase.swift
//  CERTI-iOS
//
//  Created by nayeon on 2/14/26.
//

import Foundation

protocol UploadImageToPresignedURLUseCase {
    func execute(preSignedURL: String, data: Data, contentType: String) async -> Result<Void, NetworkError>
}

final class DefaultUploadImageToPresignedURLUseCase: UploadImageToPresignedURLUseCase {
    func execute(preSignedURL: String, data: Data, contentType: String) async -> Result<Void, NetworkError> {
        guard let url = URL(string: preSignedURL) else { return .failure(.apiError(message: "Invalid URL")) }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        request.httpBody = data

        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            guard let http = response as? HTTPURLResponse else { return .failure(.decodingError) }
            guard (200...299).contains(http.statusCode) else {
                return .failure(.apiError(message: "Upload failed. status=\(http.statusCode)"))
            }
            return .success(())
        } catch {
            return .failure(.apiError(message: "Upload error: \(error.localizedDescription)"))
        }
    }
}
