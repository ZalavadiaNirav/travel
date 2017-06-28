//
//  ViewController.h
//  map
//
//  Created by Nirav Zalavadia on 26/06/17.
//  Copyright © 2017 CNSoftNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface createTripVC : UIViewController <SKDatabaseDelegate>
{
    AppDelegate *objapp;
    NSMutableArray *routesArr;
    NSMutableString *distanceStr,*durationStr;
}

-(void)saveIntoDb;

@end

