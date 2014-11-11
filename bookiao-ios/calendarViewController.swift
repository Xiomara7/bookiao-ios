//
//  calendarViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 11/11/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import Foundation

class calendarViewController: UIViewController, UICollectionViewDelegate {
    var collectionView: UICollectionViewFlowLayout!
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        
        self.view = UIView(frame: self.view.bounds)
        self.view.backgroundColor = UIColor.whiteColor()
        
        let customDesign = CustomDesign()
        self.view.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
        super.viewDidLoad()
        
        collectionView = UICollectionViewFlowLayout()
        collectionView.itemSize = CGSizeMake(20, 20)
        
        let collectionViewController = UICollectionView(frame: CGRectMake(0, 40, 30, 30), collectionViewLayout: collectionView)
        self.view.addSubview(collectionViewController)
        
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Calendario"
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView!, titleForRow row: Int, forComponent component: Int) -> String! {
        return "Calendar"
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView!, didSelectRow row: Int, inComponent component: Int) {
        println("HELLO")
    }
}