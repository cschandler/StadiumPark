//
//  StadiumDetailsViewController.m
//  StadiumPark
//
//  Created by Charles Chandler on 10/23/14.
//  Copyright (c) 2014 Flow Enterprises. All rights reserved.
//

#import "StadiumDetailsViewController.h"
#import "QRCodeViewController.h"

@interface StadiumDetailsViewController ()

// private instance variables
@property Boolean alreadyPurchased;

@end

@implementation StadiumDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.alreadyPurchased = true;
    
    // setup view
    self.stadiumNameLabel.text = self.stadiumName;
    self.priceInfoTextView.text = [NSString stringWithFormat:@"%@\n%@", self.priceInfoTextView.text, self.price];
    [self.priceInfoTextView setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:34]];
    [self.priceInfoTextView setTextColor:[UIColor whiteColor]];
    [self.priceInfoTextView setTextAlignment:NSTextAlignmentCenter];
    
    if (self.alreadyPurchased) {
        self.instructions1.hidden = NO;
        self.instructions2.hidden = NO;
        self.instructions3.hidden = NO;
        self.showQRCodeButton.hidden = NO;
        
        self.clickToPayButton.hidden = YES;
        
    } else {
        self.instructions1.hidden = YES;
        self.instructions2.hidden = YES;
        self.instructions3.hidden = YES;
        self.showQRCodeButton.hidden = YES;
        
        self.clickToPayButton.hidden = NO;
    }
    NSLog(@"stadiumId: %@", self.stadiumId);
}

#pragma mark - IBAction methods

- (IBAction)showQRCode:(UIButton *)sender {
    [self performSegueWithIdentifier:@"segueToQRCode" sender:self];
}

- (IBAction)clickToPay:(UIButton *)sender {
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    QRCodeViewController *controller = segue.destinationViewController;
    controller.qrCode = self.qrCode;
}

@end
