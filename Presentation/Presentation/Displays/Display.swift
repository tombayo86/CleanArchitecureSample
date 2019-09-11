
//  Copyright © 2019 Tom. All rights reserved.

import Foundation

/**
 Base protocol for all displays. Displays are usually instances of UIViewController or UITableViewController,
 but could be anything. Presenters use instances of this protocol to tell the view controllers what to display.
 */
protocol Display: AlertPresentableDisplay {}

