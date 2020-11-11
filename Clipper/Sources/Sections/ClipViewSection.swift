//
//  ClipViewSection.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/11.
//

import RxDataSources

enum ClipViewSection {
  case action
  case location
  case list
}

extension ClipViewSection: SectionModelType {
  var items: [ClipViewSectionItem] {
    switch self {
    case .action: return []
    case .location: return []
    case .list: return []
    }
  }

  init(original: ClipViewSection, items: [ClipViewSectionItem]) {
    switch original {
    case .action: self = .action
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
