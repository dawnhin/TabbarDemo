//
//  HomeViewController.swift
//  TabBar中间凸起
//
//  Created by 黎铭轩 on 6/12/2019.
//  Copyright © 2019 黎铭轩. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let cellID="collectionViewCell"
    lazy var collectionView:UICollectionView={
        //流水布局
        let flowlayout=UICollectionViewFlowLayout()
        flowlayout.scrollDirection=UICollectionView.ScrollDirection.vertical
        //左右最小间距
        flowlayout.minimumLineSpacing=1
        //上下最小间距
        flowlayout.minimumInteritemSpacing=10
        let collectionView=UICollectionView(frame: self.view.bounds, collectionViewLayout: flowlayout)
        collectionView.contentInsetAdjustmentBehavior=UIScrollView.ContentInsetAdjustmentBehavior.never
        collectionView.dataSource=self
        collectionView.delegate=self
        collectionView.showsVerticalScrollIndicator=false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        return collectionView
    }()
    lazy var barImageView=navigationController?.navigationBar.subviews.first
    override func viewDidLoad() {
        super.viewDidLoad()

        title="首页"
       self.collectionView.contentInsetAdjustmentBehavior=UICollectionView.ContentInsetAdjustmentBehavior.never
        self.view.addSubview(self.collectionView)
        // Do any additional setup after loading the view.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        barImageView?.alpha=0
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
extension HomeViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        if (indexPath.section % 2 == 0){
            cell.backgroundColor=UIColor.green
        }else{
            cell.backgroundColor=UIColor.yellow
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 300)
    }
    //collectionView滚动时
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let minOffset:CGFloat = -(navigationController!.navigationBar.frame.height+UIApplication.shared.statusBarFrame.height)
        let maxOffset:CGFloat = 200
        let offset = scrollView.contentOffset.y
        var alpha:CGFloat
        if offset <= 0 {
            alpha=0
        }else{
            alpha=(offset-minOffset)/(maxOffset-minOffset)
        }
        print("offset:\(offset),alpha:\(alpha)")
        barImageView?.alpha=alpha
    }
}
