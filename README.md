# 🖼 Floating-Menu

**Floating menu with expand and compress animation, written in Swift**

![alt text](https://github.com/faisalazeez/Floating-Menu/blob/master/ScreenShot_01.gif)
![alt text](https://raw.githubusercontent.com/username/projectname/branch/path/to/img.png)
![alt text](https://raw.githubusercontent.com/username/projectname/branch/path/to/img.png)

## 🔨 How to use

- Add ```FloatingMenuView.swift``` and ```FloatingMenuView.xib``` to your project. 
- If Static identifiers needed then use ```Constants.swift``` file.
- Use the ```ExtensionClass.swift``` file for Menu button extension title alignment
- You can use ```CustomButtonView``` as the UIbutton Class

You can instantiate the menu by using on a button action

```Swift
 let menuView = FloatingMenuView(frame: UIScreen.main.bounds)
 menuView.alpha = 0
 UIApplication.shared.keyWindow?.addSubview(menuView)
 UIView.animate(withDuration: 0.3, delay: 0, options: [.transitionCrossDissolve], animations: {
   menuView.alpha = 1
  }, completion: nil)
```

on each view controller you have to manually add view and set the identifier for each view controller

```Swift
  let btnCustom = CustomButtonView(frame: CGRect(x: view.bounds.maxX - 100, y: view.bounds.maxY - 100, width: 70, height: 70))
  btnCustom.controllerIdentifier = Constants.VC_TAG_VALUE.TWO_TAG
  view.addSubview(btnCustom)
```
## FloatingMenuView.swift

Inside the ```FloatingMenuView.swift``` you can set the ```COLUMN_COUNT``` and ```ROW_COUNT```

Use ```MenuModel``` as the Model data for each menu button.

  properties available to the model are
  
    - storyBoardName
    - storyBoardId
    - title
    - selectedImage
    - unSelectedImage
 
On creating the Model array of menu button set the specific properties for each.

```  
let Model = MenuModel(storyBoardName: "Main", storyBoardId: Constants.IDENTIFIERS.ONE_CONTROLLER,title: "Captain", selectedImage: "cap-icon", unSelectedImage: "cap-icon")
```

## 👤 Author

Faisal Azeez faisalazeez7@gmail.com

## 📄 License

Floating-Menu is available under the MIT license. See the LICENSE file for more info.
