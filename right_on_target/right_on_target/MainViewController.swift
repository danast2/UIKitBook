//
//  MainViewController.swift
//  right_on_target
//
//  Created by Даниил Асташов on 19.11.2024.
//

import UIKit

class MainViewController: UIViewController {

    override func loadView() {
         super.loadView()
         print("loadView MainViewController")
     }
     override func viewDidLoad() {
         super.viewDidLoad()
         print("viewDidLoad MainViewController")
     }

     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         print("viewWillAppear MainViewController")
     }

     override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         print("viewDidAppear MainViewController")
     }
    
    override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         print("viewWillDisappear MainViewController")
     }

     override func viewDidDisappear(_ animated: Bool) {
         super.viewDidDisappear(animated)
         print("viewDidDisappear MainViewController")
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
