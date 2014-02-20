MMPieChartView
============

[![Build Status](https://travis-ci.org/mdelamata/MMPieChartView.png?branch=master)](https://travis-ci.org/mdelamata/MMPieChartView)

MMPieChartView is a subclass of NSView to represent a circular chart divided into sectors, illustrating numerical proportion.

![alt tag](https://raw.github.com/mdelamata/MMPieChartView/master/MMPieChart%20Demo/capture.png)


How to use it? There's nothing to it! Firstly, import the .h :

    #import "MMPieChartView.h"

Then declare it as a property if you want to access to it properly:

    @property (nonatomic, strong) MMPieChartView *myPieChartView;

Instantiate it and add it to the desired view as usual (You could do it through IB as well):

    //creates and adds the myPieChartView wherever you want.
    self.myPieChartView = [[MMPieChartView alloc] initWithFrame:NSRectMake(0, 0, 500, 500)];
    [self.view addSubview:self.myPieChartView];
    
Set the delegates and datasource

    [self.myPieChartView setDelegate:self];
    [self.myPieChartView setDataSource:self];

Declare the sources:

    self.keysArray = @[@"aCorn",@"iPaganini",@"Solfa",@"The Kings Cup"];
    self.valuesArray = @[@10,@30,@50,@20];
    self.colorsArray = @[[NSColor redColor],
                         [NSColor orangeColor],
                         [NSColor blueColor],
                         [NSColor yellowColor]
                         ];


And finally call reloadData method.

    [self.myPieChartView reloadData];
}
    
    
DataSource Methods
------------

MMPieChartView provides a protocol called MMPieChartViewDataSource with the following methods:

Number of Pieces:

    //required Method that gets the number of pieces of the Pie Chart
    -(NSInteger)numberOfPiecesForPieChartView:(MMPieChartView*)pieChart;

Values of each piece.

    //required Method that gets the values of each piece of the Pie Chart
    -(NSNumber*)pieChartView:(MMPieChartView*)pieChart valueForValueAtIndex:(NSInteger)index;

Colors of each piece.

    //Optional method to get the colors of each piece of the Pie Chart. If this is not provided, random colors are asigned
    -(NSColor*)pieChartView:(MMPieChartView*)pieChart colorForValueAtIndex:(NSInteger)index;

Keys of each piece.

    //optional Method that gets the keys of pieces of the Pie Chart
    -(NSString*)pieChartView:(MMPieChartView*)pieChart keyForValueAtIndex:(NSInteger)index;

    
   
Delegate Methods
------------

MMPieChartView provides a protocol called MMPieChartViewDelegate with the following methods:

(this is in process) Future feature, clickable  pieces.
   
   
   
More options
------------

You can visualize the values in % or in absolute value by changing the property `MMPieChartViewVisualizationType visualizationType`, which can have the following values:

* MMPieChartViewVisualizationTypeUnits
* MMPieChartViewVisualizationTypePercentage


Also you can access to the following additional properties:

* lineWidth -> Property for the border line width of the chart.
* lineColor -> Property for the border line color of the chart.
* showKeys -> Property to show the keys or not.
 





    
