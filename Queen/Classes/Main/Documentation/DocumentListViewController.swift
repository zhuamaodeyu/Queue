//
//  DocumentListViewController.swift
//  Queen
//
//  Created by 聂子 on 2020/2/3.
//  Copyright © 2020 聂子. All rights reserved.
//

import Cocoa

class DocumentListViewController: NSViewController {
    struct IdentifityKey {
        static var cellKey = NSUserInterfaceItemIdentifier.init("DocumentListViewController_cell")
    }

    private var cellDidSelectComplation:((_ model: DocumentListModel) ->Void)?
    
    private var tableView: NSTableView = NSTableView.init()
    private var tableContainerView: NSScrollView = NSScrollView.init()
    
    private var dataSource:[DocumentListModel] = []
    
    init(cellDidSelectComplation:@escaping ((_ model: DocumentListModel) ->Void)) {
        super.init(nibName: nil, bundle: nil)
        self.cellDidSelectComplation = cellDidSelectComplation
        self.view.backgroundColor = NSColor.red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension DocumentListViewController {
    override func loadView() {
        self.view = NSView.init()
        installSubviews()
    }
    override func viewDidLoad() {
          super.viewDidLoad()
      }
}

extension DocumentListViewController {
    private func installSubviews() {
       tableView.backgroundColor = NSColor.clear
       tableView.focusRingType = .none
       tableView.autoresizesSubviews = true
       tableView.delegate = self
       tableView.dataSource = self
       tableView.headerView = nil
       tableView.rowSizeStyle = .large
       tableView.target = self
       tableView.doubleAction = #selector(tableViewDoubleAction(_:))
       let column = NSTableColumn.init(identifier: NSUserInterfaceItemIdentifier.init("lie"))
       column.width = self.tableView.frame.width
       tableView.addTableColumn(column)

       tableContainerView.backgroundColor = NSColor.clear
       tableContainerView.documentView = tableView
       tableContainerView.drawsBackground = false
       tableContainerView.hasVerticalScroller = false
       tableContainerView.autohidesScrollers = true
       tableContainerView.translatesAutoresizingMaskIntoConstraints = false
       view.addSubview(tableContainerView)

       tableContainerView.snp.makeConstraints { (make) in
           make.left.top.bottom.equalTo(self.view)
           make.width.equalTo(200)
       }
    }
}

extension DocumentListViewController: NSTableViewDelegate {

   @objc private func tableViewDoubleAction(_ sender: NSTableView) {

   }
    func tableViewSelectionDidChange(_ notification: Notification) {
        let model = dataSource[tableView.selectedRow]
        self.cellDidSelectComplation?(model)
    }
}

extension DocumentListViewController: NSTableViewDataSource {
   func numberOfRows(in tableView: NSTableView) -> Int {
       return dataSource.count
   }
   func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
       return nil
   }

   func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    var cell = tableView.makeView(withIdentifier: DocumentListViewController.IdentifityKey.cellKey, owner: self) as? DocumentListTableViewCell
       if cell == nil {
           cell = DocumentListTableViewCell.init()
           cell?.identifier = DocumentListViewController.IdentifityKey.cellKey
       }
       return cell
   }
   func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
       return true
   }
   func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
       return 50
   }
}


class DocumentListTableViewCell: NSTableCellView {
    
}


class DocumentListModel {
    var name: String
    var url: String
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
