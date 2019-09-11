
//  Copyright © 2019 Tom. All rights reserved.

import Support


///Simple struct that enables us to define `UIAlertAction`s without importing UIKit into presenters.
struct AlertAction {
    
    let title: String
    let handler: (() -> Void)?
    let style: UIAlertAction.Style
    
    let asUIAlertAction: UIAlertAction
    
    init(title: String, handler: (() -> Void)? = nil, style: UIAlertAction.Style = .default) {
        self.title = title
        self.handler = handler
        self.style = style
        
        self.asUIAlertAction = UIAlertAction(
            title: title,
            style: style,
            handler: { _ in handler?() }
        )
    }
}

/// Router than can display a wide range of alert displays.
protocol AlertPresentableDisplay: class {
    
    /**
     Displays an alert with a custom title and message.
     
     - Parameter title: The title to display.
     - Parameter message: The message to display.
     - Parameter args: An option list of args that will be inserted into the localized message using String(format:arguments:)
     */
    func showAlert(
        withTitle title: String,
        message: String
    )
    
    /**
     Displays an alert with a custom title and message.
     
     - Parameter title: The title to display.
     - Parameter message: The message to display.
     - Parameter args: An option list of args that will be inserted into the localized message using String(format:arguments:)
     */
    func showAlert(
        withTitle title: String,
        actions: [AlertAction],
        message: String
    )
    
    /**
     Displays an action sheet with a custom title, message and actions.
     
     - Parameter title: The title of the action sheet.
     - Parameter message: The message of the action sheet.
     - Parameter actions: A collection of UIAlertAction for the action sheet.
     */
    func showActionSheetWithCancel(
        title: String?,
        actions: [AlertAction],
        message: String?
    )
    
    func showAlertWithTextField(
        withTitle title: String,
        actions: [AlertAction],
        textFieldItem: TextFieldItem,
        message: String
    )
}

// MARK: - Implementation

extension AlertPresentableDisplay where Self: UIViewController {
    
    func showAlert(
        withTitle title: String,
        message: String
        ) {
        displayAlert(title: title, message: message)
    }
    
    func showAlert(
        withTitle title: String,
        actions: [AlertAction],
        message: String
        ) {
        let uiActions = actions.map{ $0.asUIAlertAction }
        displayAlert(title: title, actions: uiActions, message: message)
    }
    
    func showActionSheetWithCancel(
        title: String?,
        actions: [AlertAction],
        message: String?
        ) {
        let cancelAction: UIAlertAction = .init(title: "Cancel", style: .cancel)
        var uiActions = actions.map{ $0.asUIAlertAction }
        uiActions.append(cancelAction)
        displayAlert(withStyle: .actionSheet, title: title, actions: uiActions, message: message)
    }
    
    func showAlertWithTextField(
        withTitle title: String,
        actions: [AlertAction],
        textFieldItem: TextFieldItem,
        message: String
        ) {
        let uiActions = actions.map{ $0.asUIAlertAction }
        
        displayAlert(withStyle: .alert, title: title, actions: uiActions, message: message, textFieldItem: textFieldItem)
    }
    
    // MARK: - Internal
    
    /// This is the core function called by all show alert or error functions.
    fileprivate func displayAlert(
        withStyle style: UIAlertController.Style = .alert,
        title: String?,
        actions: [UIAlertAction] = [UIAlertAction(title: "OK", style: .default)],
        message: String?,
        textFieldItem: TextFieldItem? = nil
        ) {
        let alertController: UIAlertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: style
        )
        
        actions.forEach(alertController.addAction)
        
        if let textFieldItem = textFieldItem {
            alertController.addTextField { textField in textField.configure(with: textFieldItem) }
        }
        
        present(alertController, animated: true)
    }
}

struct TextFieldItem {
    
    typealias EditingChangedAction = (String?) -> Void
    
    let accessibilityIdentifier: String
    let text: String
    let returnKeyType: UIReturnKeyType
    let clearButtonMode: UITextField.ViewMode
    let enablesReturnKeyAutomatically: Bool
}

private extension UITextField {
    
    // MARK: - View Configurations
    
    func configure(with viewItem: TextFieldItem) {
        text = viewItem.text
        returnKeyType = viewItem.returnKeyType
        clearButtonMode = viewItem.clearButtonMode
        enablesReturnKeyAutomatically = viewItem.enablesReturnKeyAutomatically
    }
}
