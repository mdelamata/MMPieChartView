//
//  AppDelegate.h
//  MMPieChart Demo
//
//  Created by Manuel de la Mata Sáez on 07/02/14.
//  Copyright (c) 2014 Manuel de la Mata Sáez. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MMPieChartView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate,MMPieChartViewDataSource,MMPieChartViewDelegate>

@property (assign) IBOutlet NSWindow *window;

- (IBAction)showHideLabels:(id)sender;
- (IBAction)toogleVisualizationType:(id)sender;

@end
