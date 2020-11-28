//
//  ClipListViewSection.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/28.
//

import RxDataSources

enum ClipListViewSection {
  case clip([ClipListViewSectionItem])
}

extension ClipListViewSection: SectionModelType {
  var items: [ClipListViewSectionItem] {
    switch self {
    case .clip(let items): return items
    }
  }

  init(original: ClipListViewSection, items: [ClipListViewSectionItem]) {
    switch original {
    case .clip: self = .clip(items)
    }
  }
}

enum ClipListViewSectionItem {
  case clip(ClipCellReactor)
}
