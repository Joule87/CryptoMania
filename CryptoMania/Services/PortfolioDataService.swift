//
//  PortfolioDataService.swift
//  CryptoMania
//
//  Created by Julio Collado on 20/11/21.
//

import Foundation
import CoreData

class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let portfolioEntityName = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading Core Data! \(error.localizedDescription)")
            }
            self.getPortfolio()
        }
    }
    
    //MARK: - Public
    func updatePortfolio(coin: CoinModel, amount: Double) {
        if let entity = savedEntities.first(where: { $0.coinId == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    //MARK: - Private
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: portfolioEntityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching portfolio entity! \(error.localizedDescription)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinId = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data! \(error.localizedDescription)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
