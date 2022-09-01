//
//  rss_ios_stage3_task12Tests.swift
//  rss.ios.stage3-task12Tests
//
//  Created by Albert Zhloba on 24.09.21.
//

import XCTest
import CoreData
@testable import rss_ios_stage3_task12

class MockView: WalletsViewProtocol {
    func success() {}
    func failure(error: Error) {}
}

class MockStorageService: WalletsModelInput {
    var wallets: [NSManagedObject]!
    init(){}
    convenience init(wallets: [NSManagedObject]?) {
        self.init()
        self.wallets = wallets
    }
    
    func getWallets(completion: @escaping (Result<[NSManagedObject]?, Error>) -> (Void)) {
        if let wallets = wallets {
            completion(.success(wallets))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
    
    func save(name: String, color: String, currency: String) {
        
    }
    
    func deleteAllData(entity: String) {
        
    }
    
    
}

class rss_ios_stage3_task12Tests: XCTestCase {

    var view: MockView!
    var presenter: WalletsPresenter!
    var storageService: MockStorageService!
    var router: RouterProtocol!
    var wallets = [NSManagedObject]()
    
    override func setUpWithError() throws {
        let vc = UIViewController()
        let assembly = AssemblyModelBuilder()
        router = Router(viewController: vc, assemblyBuilder: assembly)
    }
    
    override func tearDownWithError() throws {
        view = nil
        storageService = nil
        presenter = nil
    }
    
    func testGetSuccessWallets(){
        let wallet:NSManagedObject = NSManagedObject()
        wallets.append(wallet)
        view = MockView()
        storageService = MockStorageService(wallets: [wallet])
        presenter = WalletsPresenter(view: view, storageService: storageService, router: router)
        var catchWallets: [NSManagedObject]!
        storageService.getWallets{result in
            switch result {
            case .success(let wallets):
            catchWallets = wallets
            case .failure(let error):
                print(error)
            }
           
        }
        XCTAssertNotEqual(catchWallets?.count, 0)
        XCTAssertEqual(catchWallets?.count, wallets.count)
    }
    
    func testGetFailureWallets(){
        let wallet:NSManagedObject = NSManagedObject()
        wallets.append(wallet)
        view = MockView()
        storageService = MockStorageService()
        presenter = WalletsPresenter(view: view, storageService: storageService, router: router)
        var catchError: Error?
        storageService.getWallets{result in
            switch result {
            case .success(let wallets):
                break
            case .failure(let error):
                catchError = error
            }
            
        }
        XCTAssertNotNil(catchError)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
