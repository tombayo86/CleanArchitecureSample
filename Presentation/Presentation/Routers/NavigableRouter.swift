
//  Copyright © 2019 Tom. All rights reserved.


public protocol NavigableRouter: class {
    
    func navigateBack()
    
    func pushInitialViewController(inStoryboardNamed storyboardName: String)
}

public extension NavigableRouter where Self: UIViewController {
    
    func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func pushInitialViewController(inStoryboardNamed storyboardName: String) {
        let viewController: UIViewController = UIStoryboard(name: storyboardName, bundle: .current).instantiateInitialViewController()!
        navigationController!.pushViewController(viewController, animated: true)
    }
}

