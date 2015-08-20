//
//  FilterType.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 19/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

enum FilterType: String {
  case Popular = "_filter:popular"
  case Featured = "_filter:featured"
  case Similar = "_filter:similar"
  case Newest = "_filter:newest"
  
  static let allValues = [Popular, Featured, Similar, Newest]
  static let allRawValues = [Popular.rawValue, Featured.rawValue, Similar.rawValue, Newest.rawValue]
}
