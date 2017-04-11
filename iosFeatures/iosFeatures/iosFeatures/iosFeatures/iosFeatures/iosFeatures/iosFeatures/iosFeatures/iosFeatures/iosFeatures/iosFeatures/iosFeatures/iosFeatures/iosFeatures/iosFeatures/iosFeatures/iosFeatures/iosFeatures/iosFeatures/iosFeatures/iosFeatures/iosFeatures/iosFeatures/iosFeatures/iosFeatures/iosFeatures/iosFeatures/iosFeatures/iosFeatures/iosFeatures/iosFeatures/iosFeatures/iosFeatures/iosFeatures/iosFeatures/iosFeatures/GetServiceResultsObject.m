//
//  GetServiceResultsObject.m
//  iosLearningProject
//
//  Created by Venkata  naraharisetty on 12/28/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import "GetServiceResultsObject.h"

@implementation GetServiceResultsObject

-(id)initWithTitle: (NSString *)oTitle andPrice: (NSString *)oPrice andCategory: (NSString *)oCategory andArtist: (NSString *)oArtist andImage: (NSMutableArray *)oImage  andLink: (NSString *)oLink;
{
    
    self = [super init];
    
    if (self)
    {
        
        _Title = oTitle;
        _Price = oPrice;
        _Category = oCategory;
        _Artist = oArtist;
        _Image = oImage;
        _Link = oLink;
    }
    return self;
}

@end
