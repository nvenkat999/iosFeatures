//
//  GetServiceImageView.m
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 2/6/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import "GetServiceImageView.h"
#import "GetServiceDetailViewController.h"

@interface GetServiceImageView ()

@end

@implementation GetServiceImageView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self LoadSubImages];
    
    _fullImageData = _fullImageArray[_fullImageIndex];
    NSData *Imagedata = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:_fullImageData]];
    _fullImageView.image = [UIImage imageWithData:Imagedata];
    [self addGestureRecognizers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)LoadSubImages{
    
    for (int i=0; i< _fullImageArray.count; i++) {
        int xCoordinate = (100+(i*45));
        CGRect viewFrame = self.view.frame;
        int yCoordinate =viewFrame.size.height-60;
        
        _subImageView = [[UIImageView alloc]init];
        [_subImageView setFrame:CGRectMake(xCoordinate, yCoordinate, 40, 40)];
        [_subImageView setTag:i];
        // _subImageView.multipleTouchEnabled = true;
        self.subImageView.userInteractionEnabled = YES;// _subImageView.userInteractionEnabled = true;
        NSString *subImageString = _fullImageArray[i];
        NSData *subImageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:subImageString]];
        _subImageView.image = [UIImage imageWithData:subImageData];
        [self.view addSubview:_subImageView];
        UITapGestureRecognizer *tapImageRecognizerForFullImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageRecognizedForFullImage:)];
        [self.subImageView addGestureRecognizer:tapImageRecognizerForFullImage];
        
    }
}

-(void) addGestureRecognizers {
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchRecognized:)];
    [self.fullImageView addGestureRecognizer:pinchRecognizer];
    
    
    
    
}

-(void) pinchRecognized:(UIPinchGestureRecognizer *) recognizer {
    
    // UIView *pinchedView = recognizer.view;
    CGFloat lastScaleFactor = 1;
    CGFloat imageMaxScale = 1.5;
    CGFloat imageMinScale = 0.7;
    CGFloat factor = [(UIPinchGestureRecognizer *)recognizer scale];
    if (lastScaleFactor*factor>imageMinScale && lastScaleFactor*factor < imageMaxScale){
        if (factor >1) {
            _fullImageView.transform = CGAffineTransformMakeScale(lastScaleFactor +(factor-1), lastScaleFactor +(factor-1));
            
        } else {
            _fullImageView.transform = CGAffineTransformMakeScale(lastScaleFactor*factor, lastScaleFactor*factor);
        }
        
    }
    factor = 1.0;
}

-(void)tapImageRecognizedForFullImage:(UITapGestureRecognizer *)taprecongizer{
    
    UIView *view = taprecongizer.view;
    
    NSInteger k = [view tag];
    _subImageView.highlighted = YES;
    
    _fullImageData = _fullImageArray[k];
    NSData *Imagedata = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:_fullImageData]];
    _fullImageView.image = [UIImage imageWithData:Imagedata];
    
    
  
}


- (IBAction)ImageSwiped:(UISwipeGestureRecognizer *)sender {
    
    UISwipeGestureRecognizerDirection direction = [(UISwipeGestureRecognizer *)sender direction];
    switch (direction) {
        case UISwipeGestureRecognizerDirectionRight:
            _fullImageIndex++;
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            _fullImageIndex--;
        default:
            break;
    }
    _fullImageIndex = (_fullImageIndex < 0) ? ([_fullImageArray count] -1):
    _fullImageIndex % [_fullImageArray count];
    _fullImageData = _fullImageArray[_fullImageIndex];
    
    NSData *Imagedata = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:_fullImageData]];
    _fullImageView.image = [UIImage imageWithData:Imagedata];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
