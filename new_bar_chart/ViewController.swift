//
//  ViewController.swift
//  new_bar_chart
//
//  Created by Alex Murphy on 4/15/17.
//  Copyright © 2017 Alex Murphy. All rights reserved.
//

import UIKit

struct BarChartItem {
    let title: String
    let height: CGFloat
}

enum CollectionViewIndex: Int { case y_axis = 0,  chart = 1 }

class YAxisCollectionViewCell: UICollectionViewCell {
    var index: Int? {
        didSet {
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tickView)
        addSubview(indexLabel)
        
        self.contentView.backgroundColor = UIColor.clear
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: tickView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 2),
            NSLayoutConstraint(item: tickView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: tickView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tickView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: indexLabel, attribute: .right, relatedBy: .equal, toItem: tickView, attribute: .left, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: indexLabel, attribute: .centerY, relatedBy: .equal, toItem: tickView, attribute: .centerY, multiplier: 1, constant: 0)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let indexLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "1"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tickView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

class BarChartCell: UICollectionViewCell {
    var data: BarChartItem? {
        didSet {
            if let data = self.data {
                self.progressViewHeightConstraint.constant = self.calcHeight(height: data.height)
            }
        }
    }
    
    func calcHeight(height: CGFloat) -> CGFloat {
        let deviceHeight = UIScreen.main.bounds.height
        return deviceHeight * height
    }
    
    let progressView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var progressViewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint(item: self.progressView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white
        self.addSubview(self.progressView)
        
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: progressView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: progressView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: progressView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0),
            progressViewHeightConstraint
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ViewController: UIViewController {
    lazy var sub_views: [UIView] = [self.xAxisView, self.barChartCollectionView, self.yAxisView]
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = UIColor.black
        self.edgesForExtendedLayout = []
        self.title = "Bar Chart"
        
        for view in sub_views { self.view.addSubview(view) }
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: yAxisView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: yAxisView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: yAxisView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: yAxisView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: xAxisView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: xAxisView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: xAxisView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: xAxisView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: barChartCollectionView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: barChartCollectionView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -50),
            NSLayoutConstraint(item: barChartCollectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: barChartCollectionView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: yAxisCollectionView, attribute: .left, relatedBy: .equal, toItem: yAxisView, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: yAxisCollectionView, attribute: .right, relatedBy: .equal, toItem: yAxisView, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: yAxisCollectionView, attribute: .top, relatedBy: .equal, toItem: yAxisView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: yAxisCollectionView, attribute: .bottom, relatedBy: .equal, toItem: yAxisView, attribute: .bottom, multiplier: 1, constant: -50)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var barChartCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.tag = CollectionViewIndex.chart.rawValue
        view.backgroundColor = UIColor.white
        view.register(BarChartCell.self, forCellWithReuseIdentifier: NSStringFromClass(BarChartCell.self))
        view.contentInset = UIEdgeInsetsMake(0, 50, 0, 0)
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var yAxisCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        view.register(YAxisCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(YAxisCollectionViewCell.self))
        view.delegate = self
        view.dataSource = self
        view.tag = CollectionViewIndex.y_axis.rawValue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var yAxisView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.masksToBounds = true
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.addSubview(self.yAxisCollectionView)
        return blurEffectView
    }()
    
    let xAxisView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let barChartData: [BarChartItem] = {
        var items = [BarChartItem]()
        for i in 0...20 {
            let item = BarChartItem(title: String(i), height:  CGFloat(Double(Float(arc4random()) / Float(UINT32_MAX))))
            items.append(item)
        }
        return items
    }()
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == CollectionViewIndex.chart.rawValue {
            return self.barChartData.count
        } else if collectionView.tag == CollectionViewIndex.y_axis.rawValue {
            return 25
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == CollectionViewIndex.chart.rawValue {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(BarChartCell.self), for: indexPath) as? BarChartCell else { return UICollectionViewCell() }
            cell.data = self.barChartData[indexPath.row]
            return cell
        } else if collectionView.tag == CollectionViewIndex.y_axis.rawValue {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(YAxisCollectionViewCell.self), for: indexPath) as? YAxisCollectionViewCell else { return UICollectionViewCell() }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == CollectionViewIndex.chart.rawValue {
            return CGSize(width: 20, height: (UIScreen.main.bounds.height - 50))
        } else if collectionView.tag == CollectionViewIndex.y_axis.rawValue {
            let cellHeight = ((self.view.frame.height - 50) / 25)
            return CGSize(width: 50, height: cellHeight)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.tag == CollectionViewIndex.y_axis.rawValue {
            return 0
        } else  {
            return 10
        }
    }
}

