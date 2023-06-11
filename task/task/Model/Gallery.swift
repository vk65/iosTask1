//
//  Gallery.swift
//  task
//
//  Created by Mac on 2023-04-26.
//

import Foundation


// MARK: - Employee
struct Gallery: Codable {
        let status: Int
        let data: [Datum]
    }

    // MARK: - Datum
    struct Datum: Codable {
        let title: String
        let image: String
    }
