//
//  QuickSlotButtonGridView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/27/23.
//

import Cocoa

class QuickSlotButtonGridView: NSCollectionView, NSCollectionViewDelegate, NSCollectionViewDataSource {
    
    private var callback: (() -> Void)?
    
    init(frame frameRect: NSRect, completion: @escaping () -> Void) {
        super.init(frame: frameRect)
        self.callback = completion
        self.frame = NSRect(x: 0, y: 0, width: 267, height: 134)
        
        let layout = NSCollectionViewFlowLayout()
        let itemSize: CGFloat = 10
        layout.itemSize = NSSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        self.collectionViewLayout = layout
        self.delegate = self
        self.dataSource = self
        
        self.register(MyCollectionViewItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "MyCollectionViewItem"))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "MyCollectionViewItem"), for: indexPath)
        let customItem = item as? MyCollectionViewItem
        
        customItem?.view.wantsLayer = true
            customItem?.button.title = "Button \(indexPath.item)"
            customItem?.button.target = self

            if indexPath.item % 2 == 0 {
                customItem?.view.layer?.backgroundColor = NSColor.red.cgColor
            } else {
                customItem?.view.layer?.backgroundColor = NSColor.blue.cgColor
            }
        
        print(customItem)
        return customItem ?? item
    }
}

class MyCollectionViewItem: NSCollectionViewItem {
    var button = NSButton()
    var uniqueID: String = UUID().uuidString
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("Unique ID: \(uniqueID)")
    }
    
    override func loadView() {
        self.view = NSView()
        self.view.addSubview(button)

        self.view.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        button.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print(nibName, nibBundle)
        print("MyCollectionViewItem instance created.")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("MyCollectionViewItem instance created.")
    }
}
