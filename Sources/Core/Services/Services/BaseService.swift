//
//  HotBoxService.swift
//
//
//  Created by Mark Evans on 12/17/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation

public class HotBoxService {

    // MARK: Properties

    public var manager = SessionManager()

    public typealias CompletionHandler = (_ success: Any?, _ error: NSError?) -> Void
    public typealias CompletionBoolHandler = (_ success: Bool) -> Void

    public static let DEFAULT_ERROR_CODE = 500
    public static let DEFAULT_ERROR_MSG = "There was a problem accessing the server. If this continues, please let us know."

    var games = [GameUI]()
    var gamesApi = [GameApi]()
    var denominations = [Int]()
    var livePools = [PoolApi]()
    var upcomingPools = [PoolApi]()
    var recentPools = [PoolApi]()
    var competitions = [CompetitionApi]()
    var transactions = [TransactionApi]()

    // MARK: Shared Instance

    public static let shared: HotBoxService = {
        let instance = HotBoxService()
        instance.setupManager()
        return instance
    }()

    // MARK: Setup Methods

    public func setupManager() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = self.getCustomHeaders(token: SecureKeys.shared.FirebaseAcessToken)
        configuration.requestCachePolicy = .reloadRevalidatingCacheData
        self.manager = SessionManager(configuration: configuration)
    }

    private func getCustomHeaders(token: String? = nil) -> [String: String] {
        var headers = [String: String]()
        headers["Platform"] = "ios"
        headers["Accept"] = "application/json"
        headers["Content-Type"] = "application/json"
        if let accessToken = token {
            headers["Authorization"] = "Bearer \(accessToken)"
        }
        else {
            headers["Authorization"] = nil
        }
        return headers
    }
}

public extension HotBoxService {
    func setupManagerWithToken(token: String) {
        SecureKeys.shared.FirebaseAcessToken = token
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = self.getCustomHeaders(token: token)
        configuration.requestCachePolicy = .reloadRevalidatingCacheData
        self.manager = SessionManager(configuration: configuration)
    }

    func saveToken(_ json: String) {
        UserDefaults.standard.set(json, forKey: Token.tokenKey)
        UserDefaults.standard.synchronize()
    }

    func clearTokenAndOAuthHandler() {
        UserDefaults.standard.removeObject(forKey: Token.tokenKey)
        UserDefaults.standard.synchronize()
        setupManager()
    }

    func errorHandler(completion: @escaping CompletionHandler) -> (DataResponse<Data>) -> Void {
        return { (res) in
            if let error = res.result.error, let response = res.response {
                completion(nil, error.handleError(response: response))
            }
            else if let error = res.result.error {
                completion(nil, error.handleError())
            }
        }
    }

    func errorHandler(completion: @escaping CompletionBoolHandler) -> (DataResponse<Data>) -> Void {
        return { (res) in
            if let _ = res.result.error, let _ = res.response {
                completion(false)
            }
            else if let _ = res.result.error {
                completion(false)
            }
        }
    }
}

public extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return self.localizedDescription }

    func handleError() -> NSError {
        return handleError(response: nil)
    }

    func handleError(response: HTTPURLResponse?) -> NSError {
        var message = ""
        var status = self.code
        if let messageResponse = response?.allHeaderFields["Message"] as? String, !messageResponse.isEmpty, let statusCode = response?.statusCode {
            message = messageResponse
            status = statusCode
        }
        else if let messageResponse = response?.allHeaderFields["message"] as? String, !messageResponse.isEmpty, let statusCode = response?.statusCode {
            message = messageResponse
            status = statusCode
        }
        else {
            message = "There was a problem accessing the server. If this continues, please let us know."
            status = 500
        }
        if self.domain.contains("401") { status = 401 }
        return NSError(domain: message, code: status, userInfo: nil)
    }
}
