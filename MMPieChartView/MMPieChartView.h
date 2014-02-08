//
//  MMPieChartView.h
//  MMPieChartView Demo
//
//  Created by Manuel de la Mata Sáez on 07/02/14.
//  Copyright (c) 2014 Manuel de la Mata Sáez. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum MMPieChartViewVisualizationType{
    MMPieChartViewVisualizationTypeUnits = 0,
    MMPieChartViewVisualizationTypePercentage
}MMPieChartViewVisualizationType;


@class MMPieChartView;

@protocol MMPieChartViewDataSource <NSObject>
@required
-(NSInteger)numberOfPiecesForPieChartView:(MMPieChartView*)pieChart;
-(NSNumber*)pieChartView:(MMPieChartView*)pieChart valueForValueAtIndex:(NSInteger)index;
@optional
-(NSColor*)pieChartView:(MMPieChartView*)pieChart colorForValueAtIndex:(NSInteger)index;
-(NSString*)pieChartView:(MMPieChartView*)pieChart keyForValueAtIndex:(NSInteger)index;

@end

@protocol MMPieChartViewDelegate <NSObject>
@optional
-(NSString*)pieChart:(MMPieChartView*)pieChart didClickAtPortionAtRow:(NSInteger)index;
@end

//Subclass of NSView that to represent a PieChart
@interface MMPieChartView : NSView

//delegate and datasource
@property (nonatomic, assign) IBOutlet id<MMPieChartViewDelegate> delegate;         //delegate
@property (nonatomic, assign) IBOutlet id<MMPieChartViewDataSource> dataSource;     //datasource

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat lineWidth;                                //border line width of each piece
@property (nonatomic, assign) NSColor *lineColor;                               //border line color of each piece
@property (nonatomic, assign) MMPieChartViewVisualizationType visualizationType;    //Percentage or absolute value
@property (nonatomic, assign) BOOL showKeys;                                    //For Displaying the key

//public Methods
-(void)reloadData; //reloads and repaint the chart

@end
