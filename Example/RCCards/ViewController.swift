//
//  ViewController.swift
//  RCCards
//
//  Created by Roberto Casula on 11/09/2018.
//  Copyright (c) 2018 Roberto Casula. All rights reserved.
//

import UIKit
import RCCards
import RxSwift
import DeepDiff

protocol RCCustomCard: RoundedCardTrait, ShadowCardTrait,
                        NoTopBottomMarginsCardTrait, TopAccentViewCardTrait {}

extension RCCustomCard {
    
    func cornerRadius() -> CGFloat {
        return 10
    }
}

extension RCCustomCard {
    
    func shadowColor() -> CGColor {
        return UIColor.black.cgColor
    }
    
    func shadowRadius() -> CGFloat {
        return 6
    }
    
    func shadowOpacity() -> Float {
        return 0.15
    }
}

class ModelCard: CardPartsViewController, RCCustomCard {
    var viewModel = BehaviorSubject<Model>(value: Model())
    var titlePart = CardPartTitleView(type: .titleOnly)
    var textPart = CardPartTextView(type: .normal)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titlePart.label.numberOfLines = 0
        
        viewModel.asObservable().subscribe(onNext: { [weak self] model in
            self?.titlePart.title = model.title
            self?.textPart.text = model.text
        }).disposed(by: bag)
        
        setupCardParts([titlePart, textPart])
    }
    
    func topAccentHeight() -> CGFloat {
        return 20
    }
    
    func topAccentColor() -> UIColor {
        return .red
    }
    
}

//class TopBarColoredCard: CardPartsViewController: RCCustomCard {
//
//    var
//}

struct Model: Equatable, Hashable {
    var title: String? = nil
    var text: String? = nil
    
    
}

class ViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var layout: UICollectionViewFlowLayout!
    var data: [Model] = []
    var dataObservable: Observable<[Model]> = Observable<[Model]>.just([])
    
    let maximum = 50
    let bag = DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        layout.estimatedItemSize = CGSize(width: 1,height: 1)
        layout.minimumLineSpacing = CardParts.theme.cardsLineSpacing
        layout.scrollDirection = .vertical
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        collectionView.backgroundColor = UIColor.color(245, green: 245, blue: 245)
//        collectionView.register(CardCell.self, forCellWithReuseIdentifier: "cell")

        collectionView.registerCardCell()
        
        let insets = UIEdgeInsets(top: CardParts.theme.cardsViewContentInsetTop, left: 0, bottom: (tabBarController?.tabBar.bounds.size.height ?? 0) + layout.minimumLineSpacing * 2, right: 0)
        collectionView.contentInset = insets
        collectionView.scrollIndicatorInsets = insets
        
        collectionView.dataSource = self
//        let ticks = Observable<Int>.interval(1, scheduler: MainScheduler.asyncInstance).map { _ in () }
//        ticks.subscribe(onNext: { [weak self] in
//            self?.randomizeData()
//        }).disposed(by: bag)
//            .merge()
//            .scan(initialRandomizedSections) { a, _ in
//                return a.randomize()
//            }
//            .map { a in
//                return a.sections
//            }
//            .share(replay: 1)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (_) in
            self.invalidateLayout()
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.randomizeData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func randomizeData() {
        let n = Int.random(in: 1...maximum)
        let oldData = Array(self.data)
        data = (0..<n).map { _ in Model(title: Lorem.sentences(1),
                                        text: Lorem.sentences(Int.random(in: 1...10)))}
        let changes = diff(old: oldData, new: data)
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reload(changes: changes, completion: nil)
            self?.collectionView.collectionViewLayout.invalidateLayout()
        }
        
//        data = [Model(title: Lorem.sentences(1),
//                      text: Lorem.sentences(Int.random(in: 0...10))),
//                Model(title: Lorem.sentences(1),
//                      text: Lorem.sentences(Int.random(in: 0...10)))]
//        collectionView.reloadData()
        
    }
    
    public func invalidateLayout() {
        DispatchQueue.main.async { [weak self] in
            let context = UICollectionViewFlowLayoutInvalidationContext()
            context.invalidateFlowLayoutAttributes = false
            self?.layout.invalidateLayout(with: context)
        }
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = data[indexPath.item]
        let controller = ModelCard()
        controller.viewModel.onNext(model)
        let cell = collectionView.dequeueReusableCardCell(withReuseIdentifier: "cell", for: indexPath, cardController: controller, parentController: self)
        
        return cell
    }

}

