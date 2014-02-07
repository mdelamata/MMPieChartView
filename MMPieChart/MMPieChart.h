//
//  MMPieChart.h
//  MMPieChart Demo
//
//  Created by Manuel de la Mata Sáez on 07/02/14.
//  Copyright (c) 2014 Manuel de la Mata Sáez. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum MMPieChartVisualizationType{
    MMPieChartVisualizationTypeUnits = 0,
    MMPieChartVisualizationTypePorcentage
}MMPieChartVisualizationType;


@class MMPieChart;

@protocol MMPieChartDataSource <NSObject>
@optional
-(NSNumber*)pieChart:(MMPieChart*)pieChart valueForValueAtIndex:(NSInteger)index;
-(NSColor*)pieChart:(MMPieChart*)pieChart colorForValueAtIndex:(NSInteger)index;
@required
-(NSString*)pieChart:(MMPieChart*)pieChart keyForValueAtIndex:(NSInteger)index;
-(NSInteger)numberOfPiecesForPieChart:(MMPieChart*)pieChart;
@end

@protocol MMPieChartDelegate <NSObject>
@optional
-(NSString*)pieChart:(MMPieChart*)pieChart didClickAtPortionAtRow:(NSInteger)index;
@end

//Subclass of NSView that to represent a PieChart
@interface MMPieChart : NSView

//delegate and datasource
@property (nonatomic, assign) IBOutlet id<MMPieChartDelegate> delegate;         //delegate
@property (nonatomic, assign) IBOutlet id<MMPieChartDataSource> dataSource;     //datasource

@property (nonatomic, assign) CGFloat lineWidth;                                //border line width of each piece
@property (nonatomic, assign) NSColor *lineColor;                               //border line color of each piece
@property (nonatomic, assign) MMPieChartVisualizationType visualizationType;    //Percentage or absolute value
@property (nonatomic, assign) BOOL showKeys;                                    //For Displaying the key

//public Methods
-(void)reloadData; //reloads and repaint the chart

@end
