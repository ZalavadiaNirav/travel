//
//  AppDelegate.h
//  map
//
//  Created by Nirav Zalavadia on 26/06/17.
//  Copyright © 2017 CNSoftNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKDatabase.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,SKDatabaseDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) SKDatabase *objsk;
@property (nonatomic,retain) NSMutableArray *coordinateArr;
@property (nonatomic,retain) NSMutableArray *polyline;


@end

