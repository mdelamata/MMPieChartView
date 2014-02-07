//
//  NSColor+HSVExtras.h
//  MMPieChart Demo
//
//  Created by Manuel de la Mata Sáez on 07/02/14.
//  Copyright (c) 2014 Manuel de la Mata Sáez. All rights reserved.
//

#import <Cocoa/Cocoa.h>


typedef struct {
    int hueValue;
    int saturationValue;
    int brightnessValue;
    CGFloat hue;
    CGFloat saturation;
    CGFloat brightness;
} HsvColor;

typedef struct {
    int redValue;
    int greenValue;
    int blueValue;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
} RgbColor;



@interface NSColor (HSVExtras)

+ (HsvColor)hsvColorFromColor:(NSColor *)color;
+ (RgbColor)rgbColorFromColor:(NSColor *)color;

-(CGFloat)hue;
-(CGFloat)saturation;
-(CGFloat)brightness;
-(CGFloat)value;
-(CGFloat)red;
-(CGFloat)green;
-(CGFloat)blue;
-(CGFloat)white;
-(CGFloat)alpha;

@end
