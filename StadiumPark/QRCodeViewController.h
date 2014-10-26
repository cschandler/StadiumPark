//
//  QRCodeViewController.h
//  StadiumPark
//
//  Created by Charles Chandler on 10/23/14.
//  Copyright (c) 2014 Flow Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCodeViewController : UIViewController

@property NSString *qrCode;

@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImage;

@end