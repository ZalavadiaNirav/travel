//
//  DriverStatusVC.h
//  map
//
//  Created by Nirav Zalavadia on 27/06/17.
//  Copyright © 2017 CNSoftNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface DriverStatusVC : UIViewController
{
    NSArray *availablePaths;
    AppDelegate *objapp;
}

@property (weak, nonatomic) IBOutlet UITextField *travelerLatTxt;
@property (weak, nonatomic) IBOutlet UITextField *travelerLongTxt;
@property (weak, nonatomic) IBOutlet UIButton *checkPositionAction;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *durationLbl;
@property (weak, nonatomic) IBOutlet UILabel *distanceLbl;
@property (weak, nonatomic) IBOutlet UIButton *viewOnMapAction;
- (IBAction)viewOnMapAction:(id)sender;

- (IBAction)checkPositionAction:(id)sender;
@end
