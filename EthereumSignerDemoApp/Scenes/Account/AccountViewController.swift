//
//  AccountViewController.swift
//  EthereumSignerDemoApp
//
//  Created by Apple Imac on 16/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit
 
class AccountViewController: UIViewController {
    
    @IBOutlet weak var accountAddress: UILabel!
    @IBOutlet weak var accountBalance: UILabel!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var validateBtn: UIButton!

    private var accountViewPresenter = AccountViewPresenter(geth: GethService(),web3: Web3Service())

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        accountViewPresenter.setViewDelegate(accountViewDelegate: self)
        customInit()
        initAccessbilityIdentifier()
    }
    private func initAccessbilityIdentifier()  {
        accountAddress.accessibilityIdentifier = "Account.AccountAddress"
        accountBalance.accessibilityIdentifier = "Account.Balance"
        signInBtn.accessibilityIdentifier = "Account.SignButton"
        validateBtn.accessibilityIdentifier = "Account.ValidateButton"
    }
    
    private func customInit() {
        self.title = RouterHelper.PageTitle.account.rawValue
        self.navigationController?.navigationBar.prefersLargeTitles = true
        if let privateKey = UserDefaultHelper.getStoredPrivateKey() {
            accountViewPresenter.initAccountBalance(privateKey: privateKey)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /*
            Sometimes syncing of node block does take much time so this code will hit every time to get the updated balance if any flip happens on stack.
         */
        if let privateKey = UserDefaultHelper.getStoredPrivateKey() {
            accountViewPresenter.initAccountBalance(privateKey: privateKey)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.viewControllers = [self] // making Account VC as rootVC once successfully set private key
    }
    
    //MARK: IBAction
    @IBAction func signBtnClicked(_ sender: Any) {
        self.performSegue(withIdentifier: RouterHelper.SegueName.signInVC.rawValue, sender: nil)
    }
    
    @IBAction func validateBtnClicked(_ sender: Any) {
        self.performSegue(withIdentifier: RouterHelper.SegueName.verificationVC.rawValue, sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AccountViewController: AccountViewPresenterProtocol {
    func displayEthereumAccountBalance(ethereumWallet: EthereumWallet) {
        accountAddress?.text = ethereumWallet.address
        accountBalance?.text = ethereumWallet.balance ?? ""
     }
    
}
