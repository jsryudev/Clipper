//
//  ClipViewSection.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/11.
//

import RxDataSources

enum ClipViewSection {
  case action(String, [ClipViewSectionItem])
  case location
  case list
}

extension ClipViewSection: SectionModelType {
  var items: [ClipViewSectionItem] {
    switch self {
    case .action(_, let items): return items
    case .location: return []
    case .list: return []
    }
  }

  var title: String {
    switch self {
    case .action(let title, _): return title
    default: return ""
    }
  }

  init(original: ClipViewSection, items: [ClipViewSectionItem]) {
    switch original {
    case .action: self = .action(original.title, items)
    case .location: self = .location
    case .list: self = .list
    }
  }
}

enum ClipViewSectionItem {
  case action
  case location
  case list
}
