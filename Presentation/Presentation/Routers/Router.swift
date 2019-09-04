
//  Copyright © 2019 Tom. All rights reserved.

import Foundation

/**
 Base protocol for all routers.
 
 Routers are instances which can route the use to other parts of the app.
 It could be to the next screen in a sequence or the home screen.
 Presenters use this protocol to decide when to do a route,
 the Router executes the route. Often UIViewControllers implement the routing protocol.
 */
public protocol Router: DismissableRouter, PerformSegueRouter, NavigableRouter, URLOpeningRouter {}
