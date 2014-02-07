//
//  NSColor+HSVExtras.m
//  MMPieChart Demo
//
//  Created by Manuel de la Mata Sáez on 07/02/14.
//  Copyright (c) 2014 Manuel de la Mata Sáez. All rights reserved.
//

#import "NSColor+HSVExtras.h"

#define COLOR_COMPONENT_SCALE_FACTOR 255.0f
#define COMPONENT_DOMAIN_DEGREES 60.0f
#define COMPONENT_MAXIMUM_DEGREES 360.0f
#define COMPONENT_OFFSET_DEGREES_GREEN 120.0f
#define COMPONENT_OFFSET_DEGREES_BLUE 240.0f
#define COMPONENT_PERCENTAGE 100.0f

@implementation NSColor (HSVExtras)



+ (HsvColor)hsvColorFromColor:(NSColor *)color {
    RgbColor rgbColor = [self rgbColorFromColor:color];
    return [self hsvColorFromRgbColor:rgbColor];
}

+ (RgbColor)rgbColorFromColor:(NSColor *)color {
    RgbColor rgbColor;
    
    CGColorRef cgColor = [color CGColor];
    const CGFloat *colorComponents = CGColorGetComponents(cgColor);
    rgbColor.red = colorComponents[0];
    rgbColor.green = colorComponents[1];
    rgbColor.blue = colorComponents[2];
    
    rgbColor.redValue = (int)(rgbColor.red * COLOR_COMPONENT_SCALE_FACTOR);
    rgbColor.greenValue = (int)(rgbColor.green * COLOR_COMPONENT_SCALE_FACTOR);
    rgbColor.blueValue = (int)(rgbColor.blue * COLOR_COMPONENT_SCALE_FACTOR);
    
    return rgbColor;
}

+ (HsvColor)hsvColorFromRgbColor:(RgbColor)color {
    
    HsvColor hsvColor;
    
    CGFloat maximumValue = MAX(color.red, color.green);
    maximumValue = MAX(maximumValue, color.blue);
    CGFloat minimumValue = MIN(color.red, color.green);
    minimumValue = MIN(minimumValue, color.blue);
    CGFloat range = maximumValue - minimumValue;
    
    hsvColor.hueValue = 0;
    if (maximumValue == minimumValue) {
        // continue
    }
    else if (maximumValue == color.red) {
        hsvColor.hueValue =
        (int)roundf(COMPONENT_DOMAIN_DEGREES * (color.green - color.blue) / range);
        if (hsvColor.hueValue < 0) {
            hsvColor.hueValue += COMPONENT_MAXIMUM_DEGREES;
        }
    }
    else if (maximumValue == color.green) {
        hsvColor.hueValue =
        (int)roundf(((COMPONENT_DOMAIN_DEGREES * (color.blue - color.red) / range) +
                     COMPONENT_OFFSET_DEGREES_GREEN));
    }
    else if (maximumValue == color.blue) {
        hsvColor.hueValue =
        (int)roundf(((COMPONENT_DOMAIN_DEGREES * (color.red - color.green) / range) +
                     COMPONENT_OFFSET_DEGREES_BLUE));
    }
    
    hsvColor.saturationValue = 0;
    if (maximumValue == 0.0f) {
        // continue
    }
    else {
        hsvColor.saturationValue =
        (int)roundf(((1.0f - (minimumValue / maximumValue)) * COMPONENT_PERCENTAGE));
    }
    
    hsvColor.brightnessValue = (int)roundf((maximumValue * COMPONENT_PERCENTAGE));
    
    hsvColor.hue = (float)hsvColor.hueValue / COMPONENT_MAXIMUM_DEGREES;
    hsvColor.saturation = (float)hsvColor.saturationValue / COMPONENT_PERCENTAGE;
    hsvColor.brightness = (float)hsvColor.brightnessValue / COMPONENT_PERCENTAGE;
    
    return hsvColor;
}

- (BOOL)canProvideRGBComponents {
	switch (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor))) {
		case kCGColorSpaceModelRGB:
		case kCGColorSpaceModelMonochrome:
			return YES;
		default:
			return NO;
	}
}

- (CGFloat)red {
	NSAssert([self canProvideRGBComponents], @"Must be an RGB color to use -red");
	const CGFloat *c = CGColorGetComponents(self.CGColor);
	return c[0];
}

- (CGFloat)green {
	NSAssert([self canProvideRGBComponents], @"Must be an RGB color to use -green");
	const CGFloat *c = CGColorGetComponents(self.CGColor);
	if (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)) == kCGColorSpaceModelMonochrome) return c[0];
	return c[1];
}

- (CGFloat)blue {
	NSAssert([self canProvideRGBComponents], @"Must be an RGB color to use -blue");
	const CGFloat *c = CGColorGetComponents(self.CGColor);
	if (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)) == kCGColorSpaceModelMonochrome) return c[0];
	return c[2];
}

- (CGFloat)white {
	NSAssert(CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)) == kCGColorSpaceModelMonochrome, @"Must be a Monochrome color to use -white");
	const CGFloat *c = CGColorGetComponents(self.CGColor);
	return c[0];
}

- (CGFloat)alpha {
	return CGColorGetAlpha(self.CGColor);
}

-(CGFloat)hue{
    HsvColor hsv;
	hsv = [NSColor hsvColorFromColor:self];
	return hsv.hue;
}

-(CGFloat)saturation{
    HsvColor hsv;
	hsv = [NSColor hsvColorFromColor:self];
	return hsv.saturation;
}
-(CGFloat)brightness{
    HsvColor hsv;
	hsv = [NSColor hsvColorFromColor:self];
	return hsv.brightness;
}
-(CGFloat)value{
	return [self brightness];
}


@end


