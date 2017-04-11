//
//  ScanBarcodeViewController.h
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 1/20/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ScanBarcodeViewController : ViewController<AVCapturePhotoCaptureDelegate, NSMetadataQueryDelegate>

@end
