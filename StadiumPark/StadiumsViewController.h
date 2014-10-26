//
//  StadiumsViewController.h
//  StadiumPark
//
//  Created by Charles Chandler on 10/23/14.
//  Copyright (c) 2014 Flow Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StadiumsViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *stadiumsPicker;

@end
