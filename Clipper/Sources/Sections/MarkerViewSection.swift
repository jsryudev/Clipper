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
  case clips(String, [MarkerViewSectionItem])
}

extension MarkerViewSection: SectionModelType {
  var items: [MarkerViewSectionItem] {
    switch self {
    case .action(_, let items): return items
    case .location(_, let items): return items
    case .clips(_, let items): return items
    }
  }

  var title: String {
    switch self {
    case .action(let title, _): return title
    case .location(let title, _): return title
    case .clips(let title, _): return title
    }
  }

  init(original: MarkerViewSection, items: [MarkerViewSectionItem]) {
    switch original {
    case .action: self = .action(original.title, items)
    case .location: self = .location(original.title, items)
    case .clips: self = .clips(original.title, items)
    }
  }
}

enum MarkerViewSectionItem {
  case action

  case location(MarkerViewLocationCellReactor)

  case clip(MarkerViewItemCellReactor)
  case more
}
