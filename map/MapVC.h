//
//  MapVC.h
//  map
//
//  Created by Nirav Zalavadia on 28/06/17.
//  Copyright © 2017 CNSoftNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>


@interface MapVC : UIViewController <GMSMapViewDelegate>
{
    GMSMapView *map;

}

- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBtn;
@end
