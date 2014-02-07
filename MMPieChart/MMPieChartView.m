//
//  MMPieChart.m
//  MMPieChart Demo
//
//  Created by Manuel de la Mata Sáez on 07/02/14.
//  Copyright (c) 2014 Manuel de la Mata Sáez. All rights reserved.
//

#import "MMPieChartView.h"
#import "NSColor+HSVExtras.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define ARC4RANDOM_MAX      0x100000000

@interface MMPieChartView ()

@property (nonatomic, strong) NSMutableArray *keysArray;
@property (nonatomic, strong) NSMutableArray *valuesArray;
@property (nonatomic,strong) NSMutableArray *relativeValuesArray;
@property (nonatomic, strong) NSMutableArray *colorsArray;
@property (nonatomic, assign) NSInteger count;

-(void)setDefaults;

@end

@implementation MMPieChartView

const CGRect frameRect = {{0.0f,0.0f},{512.0f,512.0f}};
const CGPoint center = {256.0f,256.0f};
const int radius = 170;


- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaults];
    }
    return self;
}

-(void)awakeFromNib {
    [self setDefaults];
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
    [super drawRect:dirtyRect];

    NSImage *image = [[NSImage alloc] initWithSize:NSSizeFromCGSize(frameRect.size)];
    [image lockFocus];

    [self drawChartPieces];
    [self drawString];
    
    [image unlockFocus];
    [image drawInRect:dirtyRect];
    [[NSApplication sharedApplication] setApplicationIconImage:image];
    
}

-(void)drawChartPieces{
    
    float lastAngle = 90;
    float nextAngle = 90;
    
    for (NSInteger i=0; i<self.count; i++) {
        
        lastAngle = nextAngle;
        nextAngle = lastAngle-360*[self.relativeValuesArray[i] doubleValue];
        
        //// Shadow Declarations
        NSShadow* shadow = [[NSShadow alloc] init];
        [shadow setShadowColor: [[NSColor blackColor] colorWithAlphaComponent: 0.68]];
        [shadow setShadowOffset: NSMakeSize(1, -1)];
        [shadow setShadowBlurRadius: 5];
        
        NSColor* color = (NSColor*)self.colorsArray[i];
        NSColor* color2= (NSColor*)self.colorsArray[i];
        color2 = [NSColor colorWithHue:color.hue saturation:color.saturation brightness:color.brightness-0.2 alpha:color.alpha];
        NSColor* color3= (NSColor*)self.colorsArray[i];
        color3 = [NSColor colorWithHue:color.hue saturation:color.saturation brightness:color.brightness-0.3 alpha:color.alpha];
        
        //// Gradient Declarations
        NSGradient* gradient = [[NSGradient alloc] initWithColorsAndLocations:
                                color3, 0.06,
                                color2, 0.6,
                                color, 1.0, nil];
        
        
        NSBezierPath *path = [[NSBezierPath alloc] init];
        [path moveToPoint: center];
        [path appendBezierPathWithArcWithCenter:center radius:radius startAngle:lastAngle endAngle:nextAngle clockwise:YES];
        [path lineToPoint:center];
        [path closePath];
        
        [gradient drawInBezierPath: path angle: -90];
        [shadow set];
        [self.lineColor setStroke];
        [path setLineWidth: self.lineWidth];
        [path stroke];
        
    }
}

-(void)drawString{
    
    float lastAngle = 90;
    float nextAngle = 90;
    
    for (NSInteger i=0; i<self.count; i++) {
        
        lastAngle = nextAngle;
        nextAngle = lastAngle-360*[self.relativeValuesArray[i] doubleValue];

        //// Shadow Declarations
        NSShadow* shadow = [[NSShadow alloc] init];
        [shadow setShadowColor: [[NSColor blackColor] colorWithAlphaComponent: 0.68]];
        [shadow setShadowOffset: NSMakeSize(1, -1)];
        [shadow setShadowBlurRadius: 5];
        
        NSString *textContent;
        NSString *valueKeyString = self.showKeys?[NSString stringWithFormat:@"%@\n",self.keysArray[i]]:@"";
        
        if (self.visualizationType == MMPieChartViewVisualizationTypePercentage) {
            textContent = [NSString stringWithFormat:@"%@%.01lf%%",valueKeyString,[self.relativeValuesArray[i] floatValue]*100];
        }else if (self.visualizationType == MMPieChartViewVisualizationTypeUnits) {
            textContent = [NSString stringWithFormat:@"%@%@",valueKeyString,self.valuesArray[i]];
        }
        
        
        //// Text Drawing
        CGFloat alpha = ((lastAngle-nextAngle)/2.0)+nextAngle;
        CGFloat newRadious = radius*(self.showKeys?0.6:0.7);
        CGFloat x = center.x + (newRadious)*cos(DEGREES_TO_RADIANS(alpha));
        CGFloat y = center.y + (newRadious)*sin(DEGREES_TO_RADIANS(alpha));
        CGFloat width = self.showKeys?120:70;
        CGFloat height = self.showKeys?80:40;
        
        NSRect textRect = NSMakeRect(x-width/2, y-height/2, width, height);
        [NSGraphicsContext saveGraphicsState];
        [shadow set];
        NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [textStyle setAlignment: NSCenterTextAlignment];
        
        NSDictionary* textFontAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                            [NSFont boldSystemFontOfSize: 20], NSFontAttributeName,
                                            [NSColor whiteColor], NSForegroundColorAttributeName,
                                            textStyle, NSParagraphStyleAttributeName, nil];
        
        [textContent drawInRect: NSOffsetRect(textRect, 0, 0) withAttributes: textFontAttributes];
        [NSGraphicsContext restoreGraphicsState];
        
    }
    
}


#pragma mark - Privated Methods

-(void)setDefaults{
 
    self.lineWidth = 0.5;
    self.lineColor = [NSColor blackColor];
    self.visualizationType = MMPieChartViewVisualizationTypeUnits;
    self.showKeys = YES;
}

-(void)updateData{
    
    double total = 0;
    for (NSNumber *value in self.valuesArray) {
        total = total + [value doubleValue];
    }
    
    self.relativeValuesArray = [@[] mutableCopy];

    for (NSInteger i=0; i<self.count; i++) {
        [self.relativeValuesArray addObject:@([self.valuesArray[i] doubleValue]/total)];
    }
    
    
    [self setNeedsDisplay:YES];
}


#pragma mark - Public Methods

//reloads the source Array for datasource
-(void)reloadData{
    
    //number of portions
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfPiecesForPieChartView:)]) {
        self.count = [self.dataSource numberOfPiecesForPieChartView:self];
    }else{
        self.count = 0;
        NSLog(@">> MMPieChartView. You have no implemented the numberOfPiecesForPieChartView: method.");
    }

    //values
    self.valuesArray = [@[] mutableCopy];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(pieChartView:valueForValueAtIndex:)]) {
        
        for (NSInteger i=0; i<self.count; i++) {
            [self.valuesArray addObject:[self.dataSource pieChartView:self valueForValueAtIndex:i]];
        }
  
    }else{
        NSLog(@">> MMPieChartView. You have no implemented the pieChartView:valueForValueAtIndex: method.");
    }
    
    //keys
    self.keysArray = [@[] mutableCopy];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(pieChartView:keyForValueAtIndex:)]) {
        
        for (NSInteger i=0; i<self.count; i++) {
            [self.keysArray addObject:[self.dataSource pieChartView:self keyForValueAtIndex:i]];
        }
        
    }else{
        NSLog(@">> MMPieChartView. You have no implemented the pieChartView:keyForValueAtIndex: method.");
        self.showKeys = NO;
    }
  
    //keys
    self.colorsArray = [@[] mutableCopy];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(pieChartView:colorForValueAtIndex:)]) {
        
        for (NSInteger i=0; i<self.count; i++) {
            [self.colorsArray addObject:[self.dataSource pieChartView:self colorForValueAtIndex:i]];
        }
        
    }else{
        NSLog(@">> MMPieChartView. You have no implemented the pieChartView:colorForValueAtIndex: method. Colors will be random");
        
        for (NSInteger i=0; i<self.count; i++) {
            float randomR = ((float)arc4random() / ARC4RANDOM_MAX);
            float randomG = ((double)arc4random() / ARC4RANDOM_MAX);
            float randomB = ((double)arc4random() / ARC4RANDOM_MAX);
            
            [self.colorsArray addObject:[NSColor colorWithRed:1*randomR green:1*randomG blue:1*randomB alpha:1]];
        }
    }
    
    [self updateData];
}

@end
