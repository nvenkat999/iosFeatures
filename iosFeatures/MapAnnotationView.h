//
//  MapAnnotationView.h
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 1/24/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotationView : NSObject <MKAnnotation>

@property(nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *subtitle;

-(id)initWithCoordinate:(CLLocationCoordinate2D)newCoordinate andTitle:(NSString *)newTitle andSubTitle:(NSString *)newSubTitle;

//-(id)initWithCoordinate:(CLLocationCoordinate2D)newCoordinate andTitle:(NSString *)newTitle;


@end
