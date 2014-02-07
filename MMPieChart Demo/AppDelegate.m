//
//  AppDelegate.m
//  MMPieChart Demo
//
//  Created by Manuel de la Mata Sáez on 07/02/14.
//  Copyright (c) 2014 Manuel de la Mata Sáez. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
-(void)configurePieChart;

@property (strong) IBOutlet MMPieChartView *pieChart;

@property (strong) NSArray *keysArray;
@property (strong) NSArray *valuesArray;
@property (strong) NSArray *colorsArray;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [self configurePieChart];
}

-(void)configurePieChart{
        
    self.keysArray = @[@"Value 0",@"Value 1",@"Value 2",@"Value 3"];
    self.valuesArray = @[@10,@30,@50,@20];
    self.colorsArray = @[[NSColor redColor],
                         [NSColor orangeColor],
                         [NSColor blueColor],
                         [NSColor yellowColor]
                         ];

    [self.pieChart setDelegate:self];
    [self.pieChart setDataSource:self];

    [self.pieChart reloadData];
}

#pragma mark - MMPieChartDataSource Methods

-(NSInteger)numberOfPiecesForPieChartView:(MMPieChartView *)pieChart{
    return [self.valuesArray count];
}

-(NSColor *)pieChartView:(MMPieChartView *)pieChart colorForValueAtIndex:(NSInteger)index{
    return [self.colorsArray objectAtIndex:index];
}

-(NSNumber *)pieChartView:(MMPieChartView *)pieChart valueForValueAtIndex:(NSInteger)index{
    return [self.valuesArray objectAtIndex:index];
}

-(NSString *)pieChartView:(MMPieChartView *)pieChart keyForValueAtIndex:(NSInteger)index{
    return [self.keysArray objectAtIndex:index];
}

- (IBAction)showHideLabels:(id)sender {

    self.pieChart.showKeys = !self.pieChart.showKeys ;
    [self.pieChart reloadData];
    
}

- (IBAction)toogleVisualizationType:(id)sender {
    
    if (self.pieChart.visualizationType == MMPieChartViewVisualizationTypePercentage) {
        [self.pieChart setVisualizationType:MMPieChartViewVisualizationTypeUnits];
    }else{
        [self.pieChart setVisualizationType:MMPieChartViewVisualizationTypePorcentage];
        
    }
    
    [self.pieChart reloadData];
}
@end
