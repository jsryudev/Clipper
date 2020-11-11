//
//  ClipViewSection.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/11.
//

import RxDataSources

enum ClipViewSection {
  case action(String, [ClipViewSectionItem])
  case location(String, [ClipViewSectionItem])
  case clipList(String, [ClipViewSectionItem])
}

extension ClipViewSection: SectionModelType {
  var items: [ClipViewSectionItem] {
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

  init(original: ClipViewSection, items: [ClipViewSectionItem]) {
    switch original {
    case .action: self = .action(original.title, items)
    case .location: self = .location(original.title, items)
    case .clipList: self = .clipList(original.title, items)
    }
  }
}

enum ClipViewSectionItem {
  case action
  case location(ClipViewLocationCellReactor)
  case clip
}
