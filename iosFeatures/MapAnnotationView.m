//
//  MapAnnotationView.m
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 1/24/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import "MapAnnotationView.h"
#import "MapViewController.h"

@implementation MapAnnotationView

-(id)initWithCoordinate:(CLLocationCoordinate2D)newCoordinate andTitle:(NSString *)newTitle andSubTitle:(NSString *)newSubTitle{
    self =  [super init];
    if(self){
        _coordinate = newCoordinate;
        _title = newTitle;
        _subtitle = newSubTitle;
        
    }
    return self;
}

@end
