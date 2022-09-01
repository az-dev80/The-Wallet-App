//
//  RouterTest.swift
//  rss.ios.stage3-task12Tests
//
//  Created by Albert Zhloba on 20.10.21.
//

import XCTest
import CoreData
@testable import rss_ios_stage3_task12

class MockVC: UIViewController {
    var presentedVC:UIViewController?
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentedVC = viewControllerToPresent
        super.present(viewControllerToPresent, animated: false, completion: nil)
    }
    
}

class RouterTest: XCTestCase {

    var router: RouterProtocol!
    var vc = MockVC()
    var assembly = AssemblyModelBuilder()
    
    override func setUpWithError() throws {
        router = Router(viewController: vc, assemblyBuilder: assembly)
    }

    override func tearDownWithError() throws {
        router = nil
    }
    
    func testRouter(){
        router.showAddWalletVC()
        let detailVC = vc.presentedVC
        XCTAssertTrue(detailVC is AddNewWalletVC)
    }
}
