//
//  BloodSugarWidgetsBundle.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 5.03.25.
//

import WidgetKit
import SwiftUI

@main
struct BloodSugarWidgetsBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        BloodSugarWidget()
        BloodSugarChartWidget()
    }
}
