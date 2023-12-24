//
//  ApiLogger.swift
//
//  Created by Nikolas on 23.10.2023.
//

import Alamofire
import os

public final class ApiLogger: EventMonitor {

    private let logger: Logger

    public init(logger: Logger) {
        self.logger = logger
    }

    // MARK: - EventMonitor

    public func requestDidResume(_ request: Request) {
        let allHeaders = request.request
            .flatMap { $0.allHTTPHeaderFields.map { $0.description } } ?? "None"

        logger.debug("""
        Request Started: \(request)
        Headers: \(allHeaders)
        """)

        let body = request.request
            .flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"

        logger.debug("""
        Request Started: \(request)
        Body Data: \(body)
        """)
    }

    public func request<Value>(_ request: DataRequest, didParseResponse response: AFDataResponse<Value>) {
        logger.debug("Response Received: \(response.debugDescription)")
        logger.debug("Response All Headers: \(String(describing: response.response?.allHeaderFields))")
    }
}
