//
//  MainTabbar.swift
//  TabBar中间凸起
//
//  Created by 黎铭轩 on 6/12/2019.
//  Copyright © 2019 黎铭轩. All rights reserved.
//

import UIKit
@objc protocol MainTabBarDelegate{
    @objc optional func TabbarButtonClick(tabbar:MainTabbar)
}
class MainTabbar: UITabBar {
    let Margin:CGFloat=10
    var myDelegate:MainTabBarDelegate?
    private lazy var plusButton:UIButton={
        let button = UIButton()
        button.setBackgroundImage(UIImage.init(named: "icon_ticketLogo"), for: UIControl.State.normal)
        button.setBackgroundImage(UIImage.init(named: "icon_ticketLogo"), for: UIControl.State.selected)
        button.addTarget(self, action: #selector(self.buttonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    @objc func buttonClick(){
        if self.delegate!.responds(to: #selector(self.myDelegate?.TabbarButtonClick(tabbar:))) {
            self.myDelegate?.TabbarButtonClick!(tabbar: self)
        }
    }
    private lazy var label:UILabel={
        let label=UILabel()
        label.text="发布"
        label.font=UIFont.systemFont(ofSize: 11)
        label.sizeToFit()
        label.textColor=UIColor(hexString: "#00b0f0")
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor.white
        self.shadowImage=UIImage(color: UIColor.clear)
        self.addSubview(self.plusButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        for tabBarButton in self.subviews {
            if tabBarButton.isKind(of: NSClassFromString("UITabBarButton")!){
                (tabBarButton as? UIControl)?.addTarget(self, action: #selector(tabBarButtonClick(tabBarButton:)), for: UIControl.Event.touchUpInside)
            }
        }
        let cl=NSClassFromString("UITabBarButton")
        //中间按钮水平居中
        plusButton.centerX=self.centerX
        plusButton.centerY=self.height*0.5 - Margin
        plusButton.size=CGSize(width: 60, height: 60)
        addSubview(plusButton)
        label.centerX=self.plusButton.centerX
        label.centerY=self.plusButton.frame.maxY+Margin
        
        var buttonIndex:CGFloat=0
        for button in self.subviews {
            if button .isKind(of: cl!){
                button.width=self.width/5
                button.x=button.width * buttonIndex
                buttonIndex += 1
                //如果是索引是2(从0开始的)，直接让索引+1，空出来发布按钮的位置
                if buttonIndex == 2{
                    buttonIndex += 1
                }
            }
        }
        self.bringSubviewToFront(plusButton)
    }
    @objc func tabBarButtonClick(tabBarButton:UIControl) {
        for image in tabBarButton.subviews {
            //帧动画
            if (image.isKind(of: NSClassFromString("UITabBarSwappableImageView")!)){
                let animation=CAKeyframeAnimation(keyPath: "transform.scale")
                animation.values=[1,1.3,0.9,1.15,0.95,1.02,1]
                animation.duration=1
                animation.calculationMode=CAAnimationCalculationMode.cubic
                image.layer.add(animation, forKey: nil)
            }
        }
    }
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if(!self.isHidden){
            //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
            let newPoint=self.convert(point, to: plusButton)
            if (self.plusButton.point(inside: newPoint, with: event)){
                //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
                return plusButton
            }else{
                return super .hitTest(point, with: event);
            }
        }else{
            //tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理
            return super.hitTest(point, with: event);
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

