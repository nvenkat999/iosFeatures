//
//  GetServiceResultsObject.h
//  iosLearningProject
//
//  Created by Venkata  naraharisetty on 12/28/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetServiceResultsObject : NSObject

@property (nonatomic, strong) NSString *Title;
@property (nonatomic, strong) NSString *Price;
@property (nonatomic, strong) NSString *Category;
@property (nonatomic, strong) NSString *Artist;
@property (nonatomic, strong) NSString *Link;
@property (nonatomic, strong) NSMutableArray *Image;





-(id)initWithTitle: (NSString *)oTitle andPrice: (NSString *)oPrice andCategory: (NSString *)oCategory andArtist: (NSString *)oArtist andImage: (NSMutableArray *)oImage  andLink: (NSString *)oLink;

@end
