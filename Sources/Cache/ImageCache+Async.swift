//
//  ImageCache+Async.swift
//
//  Created by Xinyu Wang on 2023/9/28.
//

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
extension ImageCache {
    /// Gets an image for a given key from the cache, either from memory storage or disk storage.
    ///
    /// - Parameters:
    ///   - key: The key used for caching the image.
    ///   - options: The `KingfisherOptionsInfo` options setting used for retrieving the image.
    /// - Returns: If the image retrieving operation finishes without problem, an `ImageCacheResult` value
    ///            will be sent to this closure as result. Otherwise, a `KingfisherError` result
    ///            with detail failing reason will be sent.
    public func retrieveImage(for key: String, options: KingfisherOptionsInfo? = nil) async throws -> ImageCacheResult {
        try await withCheckedThrowingContinuation { continuation in
            self.retrieveImage(forKey: key, options: options) { result in
                switch result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
