//
//  FloatingMenuView.swift
//  EnvoyFloatingMenu
//
//  Created by Faisal on 19/07/18.
//  Copyright © 2018 Faisal. All rights reserved.
//

import UIKit

/*
 * structure for Menu model
 */
struct MenuModel
{
    var storyBoardName: String!
    var storyBoardId: String!
    var title: String!
    var selectedImage: String!
    var unSelectedImage: String!
    
    init(storyBoardName: String,storyBoardId: String,title: String, selectedImage: String, unSelectedImage: String)
    {
        self.storyBoardName = storyBoardName
        self.storyBoardId = storyBoardId
        self.title = title
        self.selectedImage = selectedImage
        self.unSelectedImage = unSelectedImage
    }
}

class FloatingMenuView: UIView
{
    @IBOutlet weak var backGroundButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    var vcIdentifier: String!
    var selectedIndex: Int!

    let COLUMN_COUNT:CGFloat = 3
    let ROW_COUNT:CGFloat = 2
    
    var singleSize = CGSize.zero
    var initialPoint = CGPoint.zero
    var menuModelArray = [MenuModel]()
    var buttonArray = [UIButton]()
        
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        loadXib()
        createMenuModelArray()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func willMove(toSuperview newSuperview: UIView?)
    {
        super.willMove(toSuperview: self)
        setUpAnimation(isPresenting: true)
    }
    
    /*
     * Loding view from xib
     */
    func loadXib()
    {
        let mainBundle = Bundle.main
        let views = mainBundle.loadNibNamed("FloatingMenuView", owner: self, options: nil)
        let loadedSubview = views?.first as! UIView
        loadedSubview.frame = self.frame
        self.addSubview(loadedSubview)
    }
    
    /*
     * dissmiss All alert view
     */
    @IBAction func backGroundAction(_ sender: Any)
    {
        removeAllfromView()
    }
    
    /*
     * creating menu model array
     */
    func createMenuModelArray()
    {
        let firstModel = MenuModel(storyBoardName: "Main", storyBoardId: Constants.IDENTIFIERS.ONE_CONTROLLER,title: "Captain", selectedImage: "cap-icon", unSelectedImage: "cap-icon")
        let secondModel = MenuModel(storyBoardName: "Main", storyBoardId: Constants.IDENTIFIERS.TWO_CONTROLLER,title: "Thor", selectedImage: "thor-icon", unSelectedImage: "thor-icon")
        let thirdModel = MenuModel(storyBoardName: "Main", storyBoardId: Constants.IDENTIFIERS.THREE_CONTROLLER,title: "Iron Man", selectedImage: "iron-icon", unSelectedImage: "iron-icon")
        let fourthModel = MenuModel(storyBoardName: "Main", storyBoardId: Constants.IDENTIFIERS.FOUR_CONTROLLER,title: "Spider Man", selectedImage: "spider-icon", unSelectedImage: "spider-icon")
        let fifthModel = MenuModel(storyBoardName: "Main", storyBoardId: Constants.IDENTIFIERS.FIVE_CONTROLLER,title: "Hulk", selectedImage: "Hulk-icon", unSelectedImage: "Hulk-icon")
        let sixthModel = MenuModel(storyBoardName: "Main", storyBoardId: Constants.IDENTIFIERS.SIX_CONTROLLER,title: "Thanos", selectedImage: "Thanos-icon", unSelectedImage: "Thanos-icon")
        
        menuModelArray.append(firstModel)
        menuModelArray.append(secondModel)
        menuModelArray.append(thirdModel)
        menuModelArray.append(fourthModel)
        menuModelArray.append(fifthModel)
        menuModelArray.append(sixthModel)
    }
    
    /*
     * initiating animation and setuping buttons
     */
    func setUpAnimation(isPresenting: Bool)
    {
        /*
         * accessing the rootview controller
         */
        if let window = UIApplication.shared.delegate?.window
        {
            if var viewController = window?.rootViewController
            {
                /*
                 * handle if root controller is navigation controller
                 */
                if(viewController is UINavigationController){
                    viewController = (viewController as! UINavigationController).viewControllers.first!
                }
                vcIdentifier = (NSStringFromClass(viewController.classForCoder)).components(separatedBy: ".").last!
            }
        }
        
        layoutIfNeeded()
        
        let width  = mainView.bounds.width
        let height = mainView.bounds.height
        
        singleSize = CGSize(width: width/COLUMN_COUNT, height: height/ROW_COUNT)
        initialPoint = CGPoint(x: width - singleSize.width, y: height - singleSize.height)
        
        for (index,model) in menuModelArray.enumerated()
        {
            let xCount = (index % Int(COLUMN_COUNT) * Int(ROW_COUNT)) + 1
            let yCount:CGFloat = (index < Int(COLUMN_COUNT) ? 1 : 3)

            /*
             * dispalying and removing animation according to the Bool value
             */
            if isPresenting
            {
                let button = UIButton()
                button.tag = index
                button.setImage(UIImage(named: (model.storyBoardId == vcIdentifier ? model.selectedImage : model.unSelectedImage)), for: .normal)
                button.setTitle(model.title, for: .normal)
                button.alignTextBelow()
                
                /*
                 * adding target for each button
                 */
                addTargetForAllButtons(button: button)
                
                /*
                 * adding display animation for each button
                 */
                addOrRemoveAnimationForButton(isPresenting: isPresenting, button: button, xCount: CGFloat(xCount), yCount: yCount)
                
                /*
                 * saving each button object to an array for later use (removing animation)
                 */
                buttonArray.append(button)
            }
            else
            {
                /*
                 * adding dismiss animation for each button
                 */
                addOrRemoveAnimationForButton(isPresenting: isPresenting, button: buttonArray[index], xCount: CGFloat(xCount), yCount: yCount)
            }
        }
    }
    
    /*
     * present and dissmissing animation methods
     */
    func addOrRemoveAnimationForButton(isPresenting:Bool, button buttonObj: UIButton, xCount: CGFloat, yCount:CGFloat)
    {
        let initialFrame = CGRect(x: initialPoint.x, y: initialPoint.y, width: singleSize.width, height: singleSize.height)
        
        /*
         * final will be the center point of each button object
         */
        var finalPoint = CGPoint()
        
        /*
         * drawing path for button to move
         */
        let path1 = CGMutablePath()
        
        if isPresenting
        {
            /*
             * assigning each button's center point(finalPoint) and adding it to subview
             */
            buttonObj.frame = initialFrame
            finalPoint = CGPoint(x: (singleSize.width/2) * xCount, y: (singleSize.height/2) * yCount)
            path1.move(to: CGPoint(x: buttonObj.center.x, y: buttonObj.center.y), transform: .identity)
            path1.addLine(to: finalPoint, transform: .identity)
            mainView.addSubview(buttonObj)
        }
        else
        {
            /*
             * assigning each buttons center point(finalPoint) back to its intial point
             */
            finalPoint = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            path1.move(to: CGPoint(x: (singleSize.width/2) * xCount, y: (singleSize.height/2) * yCount), transform: .identity)
            path1.addLine(to: CGPoint(x: initialFrame.midX, y: initialFrame.midY), transform: .identity)
        }
        
        /*
         * adding move animation to each button
         */
        let move1 = CAKeyframeAnimation(keyPath: "position")
        move1.path = path1
        move1.duration = 0.3
        buttonObj.layer.position = finalPoint
        buttonObj.layer.add(move1, forKey: "move the view")
    }
    
    /*
     * removing all views from superview
     */
    func removeAllfromView(completionHandler: ((Bool?) -> ())? = nil)
    {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.transitionCrossDissolve], animations: {
            self.setUpAnimation(isPresenting: false)
            self.alpha = 0
            
        }, completion: { (success) in
            self.removeFromSuperview()
            completionHandler?(true)
        })
    }
    
    /*
     * add target for all buttons
     */
    func addTargetForAllButtons(button : UIButton)
    {
        button.addTarget(self, action: #selector(loadViewContrllollers(sender:)), for: .touchUpInside)
    }
    
    /*
     * load view controllers on action
     */
    @objc func loadViewContrllollers(sender: UIButton)
    {
        let modelObject = menuModelArray[sender.tag]
        removeAllfromView()
        if vcIdentifier == modelObject.storyBoardId
        {
            return
        }
        let storyBoard = UIStoryboard(name:modelObject.storyBoardName, bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: modelObject.storyBoardId)
        
        let nav1 = UINavigationController(rootViewController: viewController)
        let window = (UIApplication.shared.delegate as! AppDelegate).window!
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {}, completion: nil)
        window.rootViewController = nav1
        window.makeKeyAndVisible()
    }
}
