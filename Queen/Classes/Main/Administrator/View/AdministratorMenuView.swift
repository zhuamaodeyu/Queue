//
//  AdministratorMenuView.swift
//  Queen
//
//  Created by 聂子 on 2019/7/26.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

protocol AdministratorMenuViewDelegate: class {
    func menuView(_ menuView: AdministratorMenuView, didSelectRowAt indexPath: Int)
}
protocol AdministratorMenuViewDataSource: class {
    func numberOfSections(in menuView: AdministratorMenuView) -> Int
    func menuView(_ menuView: AdministratorMenuView, cellForRowAt indexPath: Int) -> NSCollectionViewItem?
    func menuView(_ menuView: AdministratorMenuView, cell size:IndexPath) -> NSSize?
}

class AdministratorMenuView: NSScrollView {
    private var collectionView: NSCollectionView!

    weak var delegate: AdministratorMenuViewDelegate?
    weak var dataSource: AdministratorMenuViewDataSource?

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        self.backgroundColor = NSColor.clear
        self.drawsBackground = false
        self.hasVerticalScroller = false
        self.autohidesScrollers = true
        self.translatesAutoresizingMaskIntoConstraints = false

        installSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AdministratorMenuView {
    func reloadData()  {
        self.collectionView.reloadData()
    }
    func makeItem(withIdentifier identifier: NSUserInterfaceItemIdentifier, for indexPath: Int) -> NSCollectionViewItem? {
        return  self.collectionView.makeItem(withIdentifier: identifier, for: IndexPath.init(item: indexPath, section: 0))
    }
    func register(_ itemClass: AnyClass?, forItemWithIdentifier identifier: NSUserInterfaceItemIdentifier) {
        collectionView.register(itemClass, forItemWithIdentifier: identifier)
    }
}
extension AdministratorMenuView {
    private func installSubviews() {

        let layout =  NSCollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        
        self.collectionView = NSCollectionView.init(frame: .zero)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = layout
        self.collectionView.isSelectable = true
        self.collectionView.allowsMultipleSelection = false
        self.collectionView.backgroundColor = NSColor.randomColor
        self.collectionView.register(NSCollectionViewItem.self , forItemWithIdentifier: NSUserInterfaceItemIdentifier.init(NSCollectionViewItem.className()))
        self.documentView = collectionView
    }
}

extension AdministratorMenuView:NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        if let index = indexPaths.first?.item {
            self.delegate?.menuView(self, didSelectRowAt: index)
        }
        collectionView.deselectAll(self)
    }
}

extension AdministratorMenuView: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource?.numberOfSections(in: self) ?? 0
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let view = self.dataSource?.menuView(self, cellForRowAt: indexPath.item)
        if let view = view {
            return view
        }
        return collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier.init(NSCollectionViewItem.className()), for: indexPath)
    }
}

extension AdministratorMenuView: NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        let size = self.dataSource?.menuView(self, cell: indexPath) ?? NSSize.init(width: collectionView.width, height: collectionView.width)
        return size
    }
}
