//
//  StorageConfig.swift
//  Box42
//
//  Created by Chanhee Kim on 8/16/23.
//

enum StorageThreshold: Double {
    case percentage05 = 0.05
    case percentage10 = 0.1
    case percentage30 = 0.3
    case percentage50 = 0.5
}

enum StoragePeriod: Double {
    case period1s = 1.0
    case period3s = 3.0
    case period5s = 5.0
    case period10s = 10.0
}

import Combine

class StorageConfig: ObservableObject {
    static let shared = StorageConfig()

    @Published var threshold: StorageThreshold
    @Published var period: StoragePeriod
    
    init(_ threshold: StorageThreshold = .percentage30, _ period: StoragePeriod = .period3s) {
        self.threshold = threshold
        self.period = period
    }
    
    func setThreshold(_ threshold: StorageThreshold) {
        self.threshold = threshold
        print(self.threshold)
    }
    
    func setPeriod(_ period: StoragePeriod) {
        self.period = period
        print(self.period)
    }
}
