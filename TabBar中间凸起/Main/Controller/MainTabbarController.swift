//
//  MainTabbarController.swift
//  TabBar中间凸起
//
//  Created by 黎铭轩 on 6/12/2019.
//  Copyright © 2019 黎铭轩. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate=self;

        // Do any additional setup after loading the view.
        addChildViewControllers()
        setupNavigationView()
        let tabBar=MainTabbar()
        tabBar.myDelegate=self
        self.setValue(tabBar, forKey: "tabBar")
    }
    func addChildViewControllers(){
        let home=HomeViewController()
        addChildViewController(viewController: home, title: "首页", normalImage: UIImage.originalImageNamed("icon_home_"), selectImage: UIImage.originalImageNamed("icon_home_sign"), navigationBarTitle: "")
        let category=GoodsCategroyViewController()
        addChildViewController(viewController: category, title: "分类", normalImage: UIImage.originalImageNamed("icon_classification_"), selectImage: UIImage.originalImageNamed("icon_classification_sign"), navigationBarTitle: "分类")
        let shopcar=ShoppingCarViewController()
        addChildViewController(viewController: shopcar, title: "购物车", normalImage: UIImage.originalImageNamed("icon_cart"), selectImage: UIImage.originalImageNamed("icon_car_sign"), navigationBarTitle: "购物车")
        let mine=MineViewController()
        addChildViewController(viewController: mine, title: "我的", normalImage: UIImage.originalImageNamed("icon_presonal"), selectImage: UIImage.originalImageNamed("icon_presonal_sign"), navigationBarTitle: "我的")
    }
    // MARK: - 添加子控制器
    func addChildViewController(viewController:UIViewController,title:String,normalImage:UIImage,selectImage:UIImage,navigationBarTitle:String) {
        viewController.navigationItem.title=title
        viewController.tabBarItem.title=navigationBarTitle
        viewController.tabBarItem.image=normalImage
        viewController.tabBarItem.selectedImage=selectImage
        let textAttributes=NSMutableDictionary()
        textAttributes[NSAttributedString.Key.foregroundColor]=UIColor(hexString: "#00b0f0")
        textAttributes[NSAttributedString.Key.font]=UIFont.systemFont(ofSize: 11)
        viewController.tabBarItem.setTitleTextAttributes(textAttributes as? [NSAttributedString.Key : Any], for: UIControl.State.normal)
        let selectedTextAttributes=NSMutableDictionary()
        selectedTextAttributes[NSAttributedString.Key.foregroundColor]=UIColor.red
        selectedTextAttributes[NSAttributedString.Key.font]=UIFont.systemFont(ofSize: 12)
        viewController.tabBarItem.setTitleTextAttributes(selectedTextAttributes as? [NSAttributedString.Key : Any], for: UIControl.State.selected)
        //添加子控制器到导航控制器
        let navigation = UINavigationController(rootViewController: viewController)
        self.addChild(navigation)
    }
    func setupNavigationView(){
        let itemBack=UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem=itemBack
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
extension MainTabbarController:UITabBarControllerDelegate,MainTabBarDelegate{
    func TabbarButtonClick(tabbar: MainTabbar) {
        let project=ProjectViewController()
        let navigation=UINavigationController(rootViewController: project)
        self.addChild(navigation)
    }
}
