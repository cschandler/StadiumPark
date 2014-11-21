//
//  SignUpViewController.h
//  StadiumPark
//
//  Created by Charles Chandler on 11/20/14.
//  Copyright (c) 2014 Flow Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

- (IBAction)continueTapped:(UIButton *)sender;

@end
