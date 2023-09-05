////
////  BookmarkTableView.swift
////  Box42
////
////  Created by Chanhee Kim on 9/4/23.
////
//
//import AppKit
//import SnapKit
//import Combine
//
//class BookmarkTableView: NSTableView {
//    var onButtonClicked: ((DraggableButton) -> Void)?
//
//    var buttonTitleArray: [String] {
//        return BookmarkViewModel.shared.bookMarkList.map { $0.name }
//    }
//
//    var urlArray: [String] {
//        return BookmarkViewModel.shared.bookMarkList.map { $0.url }
//    }
//    
//    var viewModel: BookmarkViewModel? {
//        didSet {
//            print("ViewModel has been set.")
//            setupBindings()
//        }
//    }
//
//    var cancellables: Set<AnyCancellable> = []
//    
//    private func setupBindings() {
//        print("Setting up bindings...") // 디버깅 로그
//        viewModel?.$bookMarkList.sink(receiveValue: { [weak self] newScripts in
//            print("Received new scripts: \(newScripts)") // 디버깅 로그
//            DispatchQueue.main.async {
//                self?.reloadData()
//            }
//        }).store(in: &cancellables)
//    }
//    
//    func setup() {
//        self.delegate = self
//        self.dataSource = self
//        self.registerForDraggedTypes([NSPasteboard.PasteboardType.string])
//        
//        self.wantsLayer = true
//        self.backgroundColor = NSColor(hex: "#E7E7E7")
//        self.focusRingType = .none
//        self.headerView = nil
//        self.autoresizingMask = [.width, .height]
//        self.selectionHighlightStyle = .none
//        self.intercellSpacing = NSSize(width: 0, height: 0)
//        self.setDraggingSourceOperationMask(.move, forLocal: true)
//        
//        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("Bookmark"))
//        column.title = ""
//        //        column.width = 100
//        column.resizingMask = .autoresizingMask
//        
//        self.addTableColumn(column)
//    }
//}
//
//extension BookmarkTableView: NSTableViewDelegate, NSTableViewDataSource {
//
//    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
//        if dropOperation == .above {
//            return .move
//        } else {
//            return []
//        }
//    }
//    
//    func tableView(_ aTableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {
//        guard let str = info.draggingPasteboard.string(forType: .string), let from = Int(str) else {
//            return false
//        }
//        
//        let to = (from < row) ? row - 1 : row
//        let item = BookmarkViewModel.shared.bookMarkList[from]
//        BookmarkViewModel.shared.bookMarkList.remove(at: from)
//        BookmarkViewModel.shared.bookMarkList.insert(item, at: to)
//        self.reloadData()
//        
//        for (_, subview) in self.subviews.enumerated() {
//            guard let cellView = subview as? CustomTableCellView else {
//                continue
//            }
//            
//            cellView.button.title = buttonTitleArray[cellView.rowIndex]
//        }
//        
//        return true
//    }
//    
//    func numberOfRows(in tableView: NSTableView) -> Int {
//        return BookmarkViewModel.shared.bookMarkList.count
//    }
//    
//    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
//        let cellView = ButtonTableCellView()
//        cellView.rowIndex = row
//        
//        let button = DraggableButton(frame: NSRect(x: 0, y: 0, width: 300, height: 44))
//        button.tag = row
//        button.bezelStyle = .inline
//        button.isBordered = false
//        button.title = ""
//        button.registerForDraggedTypes([NSPasteboard.PasteboardType.string])
//        button.target = self
//        button.action = #selector(buttonClicked(_:))
//        button.delegate = self
//        
//        let label = NSTextField(frame: NSRect(x: 26 + 21 + 8, y: 25 / 2, width: button.bounds.width, height: button.bounds.height))
//        
//        label.stringValue = buttonTitleArray[row]
//        label.backgroundColor = .clear
//        label.isBordered = false
//        label.isEditable = false
//        
//        let attributes : [NSAttributedString.Key : Any] =
//        [
//            NSAttributedString.Key.font : NSFont.systemFont(ofSize:18.0, weight: .light),
//            NSAttributedString.Key.foregroundColor : NSColor.black,
//        ]
//        let attributedStringTitle = NSAttributedString(string: label.stringValue , attributes:
//                                                        attributes)
//        label.attributedStringValue=attributedStringTitle
//        button.addSubview(label)
//        
//        
//        //        let image = NSImage(named: NSImage.Name("bookmark-default"))
//        //        image?.size = NSSize(width: 21, height: 21)
//        //        button.image = image
//        //        button.imagePosition = .imageLeading
//        //        button.image?.alignmentRect = NSRect(x: 0, y: 0, width: 21, height: 21)
//        
//        let imageView = NSImageView(frame: NSRect(x: 26, y: 25 / 2, width: 21, height: 21))
//        imageView.image = NSImage(named: NSImage.Name("bookmark-default"))
//        imageView.imageScaling = .scaleProportionallyUpOrDown
//        imageView.imageAlignment = .alignCenter
//        button.addSubview(imageView)
//        
//        
//        
//        cellView.addSubview(button)
//        
//        button.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(2)
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//            //            make.width.equalTo(268)
//            make.width.lessThanOrEqualTo(268)
//            make.height.equalTo(44)
//        }
//        
//        tableView.rowHeight = 50
//        
//        if row == selectedRow {
//            button.wantsLayer = true
//            button.layer?.cornerRadius = 12
//            button.layer?.backgroundColor = NSColor.white.cgColor
//        } else {
//            button.wantsLayer = true
//            button.layer?.cornerRadius = 12
//            button.layer?.backgroundColor = NSColor.clear.cgColor
//        }
//        
//        return cellView
//    }
//    
//    func tableView(_ tableView: NSTableView, pasteboardWriterForRow row: Int) -> NSPasteboardWriting? {
//        let pasteboardItem = NSPasteboardItem()
//        pasteboardItem.setString(String(row), forType: .string)
//        return pasteboardItem
//    }
//    
//    func sendUpdatedDataToServer() {
//        let urlList = zip(buttonTitleArray, urlArray).map { ["name": $0.0, "url": $0.1] }
//        let jsonData = try? JSONSerialization.data(withJSONObject: ["urlList": urlList])
//        
//        var request = URLRequest(url: URL(string:"https://api.42box.kr/user-service/users/me/url-list")!)
//        request.httpMethod = "POST"
//        request.httpBody = jsonData
//        
//        URLSession.shared.dataTask(with:request) { (data, response, error) in
//            if error != nil{
//                print(error!.localizedDescription)
//            }
//            else{
//                print("Data posted successfully")
//            }
//        }.resume()
//    }
//}
