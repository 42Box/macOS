//
//  QuickSlotButtonCollectionViewController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/27/23.
//

import Cocoa
import Combine

class QuickSlotButtonCollectionViewController: NSViewController {
    @IBOutlet weak var quickSlotButtonCollectionView: NSCollectionView!
    var viewModel = QuickSlotViewModel.shared
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeCombine()
        
        quickSlotButtonCollectionView.delegate = self
        quickSlotButtonCollectionView.dataSource = self
        
        quickSlotButtonCollectionView.register(NSNib(nibNamed: NSNib.Name("QuickSlotButtonViewItem"), bundle: nil), forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "QuickSlotButtonViewItem"))
        
        initializeView()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        constraintsView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    init() {
        super.init(nibName: "QuickSlotButtonCollectionViewController", bundle: nil)
    }
    
    func initializeCombine() {
        viewModel.$buttons
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.quickSlotButtonCollectionView.reloadData()
                }
            }
            .store(in: &cancellables)
    }
    
    func initializeView() {
        // MARK: - Setup FlowLayout View
        let flowLayout: NSCollectionViewFlowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: QuickSlotUI.size.button, height: QuickSlotUI.size.button)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = QuickSlotUI.size.lineSpacing
        flowLayout.sectionInset = NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        quickSlotButtonCollectionView.collectionViewLayout = flowLayout
        
        // MARK: - Setup Collection View
        quickSlotButtonCollectionView.wantsLayer = true
        quickSlotButtonCollectionView.layer?.borderWidth = 0
        quickSlotButtonCollectionView.layer?.borderColor = NSColor.clear.cgColor
        quickSlotButtonCollectionView.backgroundColors = [NSColor.clear]
        
        if let scrollView = quickSlotButtonCollectionView.enclosingScrollView {
            //            scrollView.hasVerticalScroller = false
            //            scrollView.hasHorizontalScroller = false
            scrollView.backgroundColor = NSColor.clear
            scrollView.drawsBackground = false
        }
    }
    
    func constraintsView() {
        quickSlotButtonCollectionView.frame = self.view.bounds
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension QuickSlotButtonCollectionViewController: NSCollectionViewDelegate, NSCollectionViewDataSource {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.buttons.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "QuickSlotButtonViewItem"), for: indexPath)
        print("current item index>", indexPath.item)
        if let customItem = item as? QuickSlotButtonViewItem {
            
            for subview in customItem.view.subviews {
                subview.removeFromSuperview()
            }
            
            if customItem.view.subviews.isEmpty {
                let btn = QuickSlotItemButton(indexPath.item)
                btn.action = #selector(collectionButtonTapped)
                btn.target = self
                
                let label = QuickSlotItemLabel(indexPath.item)
                
                customItem.view.addSubview(btn)
                customItem.view.addSubview(label)
                
                btn.snp.makeConstraints { make in
                    make.left.top.right.equalToSuperview()
//                    make.width.equalTo(58)
                    make.height.equalTo(58)
                }
                
                label.snp.makeConstraints { make in
                    make.top.equalTo(btn.snp.bottom)
                    make.left.right.bottom.equalToSuperview()
                }
            }
        }
        return item
    }
//    func collectionView(_ collectionView: NSCollectionView, mouseEnteredAt indexPath: IndexPath) {
//           // 호버 효과를 적용하려는 코드
//           if let item = collectionView.item(at: indexPath) as? QuickSlotButtonViewItem,
//              let button = item.view.subviews.first as? QuickSlotItemButton {
//               button.mouseEntered(with: NSEvent()) // 호버 효과 메서드 호출
//           }
//       }
//
//       func collectionView(_ collectionView: NSCollectionView, mouseExitedAt indexPath: IndexPath) {
//           // 호버 효과를 해제하려는 코드
//           if let item = collectionView.item(at: indexPath) as? QuickSlotButtonViewItem,
//              let button = item.view.subviews.first as? QuickSlotItemButton {
//               button.mouseExited(with: NSEvent()) // 호버 효과 해제 메서드 호출
//           }
//       }
}

extension QuickSlotButtonCollectionViewController {
    @objc func collectionButtonTapped(_ sender: NSButton) {
        NotificationCenter.default.post(name: .collectionButtonTapped, object: sender)
    }
}

// MARK: - Notification Name collectionButtonTapped
extension Notification.Name {
    static let collectionButtonTapped = Notification.Name("collectionButtonTapped")
    static let collectionHeaderTapped = Notification.Name("collectionHeaderTapped")
}
