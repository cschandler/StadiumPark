//
//  StadiumDetailsViewController.h
//  StadiumPark
//
//  Created by Charles Chandler on 10/23/14.
//  Copyright (c) 2014 Flow Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StadiumDetailsViewController : UIViewController

// received variables from StadiumsViewController
@property NSString *stadiumName;
@property int stadiumId;
// from interface builder
@property (weak, nonatomic) IBOutlet UITextField *instructions1;
@property (weak, nonatomic) IBOutlet UITextField *instructions2;
@property (weak, nonatomic) IBOutlet UITextField *instructions3;
@property (weak, nonatomic) IBOutlet UIButton *showQRCodeButton;
@property (weak, nonatomic) IBOutlet UILabel *stadiumNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stadiumLogoImageView;
@property (weak, nonatomic) IBOutlet UITextView *priceInfoTextView;
@property (weak, nonatomic) IBOutlet UIButton *clickToPayButton;
// IBActions
- (IBAction)showQRCode:(UIButton *)sender;
- (IBAction)clickToPay:(UIButton *)sender;

@end
