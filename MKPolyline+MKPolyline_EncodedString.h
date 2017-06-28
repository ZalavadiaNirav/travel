//
//  MKPolyline+MKPolyline_EncodedString.h
//  map
//
//  Created by Nirav Zalavadia on 27/06/17.
//  Copyright © 2017 CNSoftNet. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "AppDelegate.h"

@interface MKPolyline (MKPolyline_EncodedString)

+ (MKPolyline *)polylineWithEncodedString:(NSString *)encodedString;


@end
