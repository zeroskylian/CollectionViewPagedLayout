//
//  ViewController.swift
//  SwiftTs
//
//  Created by Xinbo Lian on 2020/9/24.
//

import UIKit



class ViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        
        let layout = CollectionViewPagedLayout()
        let width =  UIScreen.main.bounds.size.width / CGFloat(layout.column)
        layout.itemSize = CGSize(width: width, height: width)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width , height: ceil( width * 2)), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TestCell.self, forCellWithReuseIdentifier: "collectionView")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "empty")
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "update", style: .plain, target: self, action: #selector(updateSnapShot))
        view.addSubview(collectionView)
        edgesForExtendedLayout = []
    }
    
    
    @objc func updateSnapShot()
    {
        
    }
}


extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        13
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionView", for: indexPath) as! TestCell
        cell.textLb.text = "第 \(indexPath.row)"
        return cell
    }
}


class TestCell: UICollectionViewCell {
    
    let textLb:UILabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textLb.textColor = .blue
        textLb.font = .systemFont(ofSize: 14)
        textLb.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textLb)
        NSLayoutConstraint.activate([
            textLb.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textLb.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
