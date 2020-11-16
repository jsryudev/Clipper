//
//  MarkerViewSection.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/11.
//

import RxDataSources

enum MarkerViewSection {
  case action(String, [MarkerViewSectionItem])
  case location(String, [MarkerViewSectionItem])
  case clipList(String, [MarkerViewSectionItem])
}

extension MarkerViewSection: SectionModelType {
  var items: [MarkerViewSectionItem] {
    switch self {
    case .action(_, let items): return items
    case .location(_, let items): return items
    case .clipList(_, let items): return items
    }
  }

  var title: String {
    switch self {
    case .action(let title, _): return title
    case .location(let title, _): return title
    case .clipList(let title, _): return title
    }
  }

  init(original: MarkerViewSection, items: [MarkerViewSectionItem]) {
    switch original {
    case .action: self = .action(original.title, items)
    case .location: self = .location(original.title, items)
    case .clipList: self = .clipList(original.title, items)
    }
  }
}

enum MarkerViewSectionItem {
  case action
  case location(MarkerViewLocationCellReactor)
  case clip(MarkerViewItemCellReactor)
}
