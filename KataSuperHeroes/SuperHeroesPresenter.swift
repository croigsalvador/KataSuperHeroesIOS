//
//  SuperHeroesPresenter.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 12/01/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation
import BothamUI

class SuperHeroesPresenter: BothamPresenter, BothamNavigationPresenter {

    private weak var ui: SuperHeroesUI?
    private let getSuperHeroes: GetSuperHeroes

    init(ui: SuperHeroesUI, getSuperHeroes: GetSuperHeroes) {
        self.ui = ui
        self.getSuperHeroes = getSuperHeroes
    }

    func viewDidLoad() {
        ui?.showLoader()
        getSuperHeroes.execute { superHeroes in
            self.ui?.hideLoader()
            if superHeroes.isEmpty {
                self.ui?.showEmptyCase()
            } else {
                self.ui?.showItems(superHeroes)
            }
        }
    }

    func itemWasTapped(item: SuperHero) {
        let superHeroDetailViewController = ServiceLocator().provideSuperHeroDetailViewController(item.name)
        ui?.openSuperHeroDetailScreen(superHeroDetailViewController)
    }
}

protocol SuperHeroesUI: BothamUI, BothamLoadingUI {

    func showEmptyCase()
    func showItems(items: [SuperHero])
    func openSuperHeroDetailScreen(superHeroDetailViewController: UIViewController)

}
