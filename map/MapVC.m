//
//  MapVC.m
//  map
//
//  Created by Nirav Zalavadia on 28/06/17.
//  Copyright © 2017 CNSoftNet. All rights reserved.
//

#import "MapVC.h"
#import "AppDelegate.h"

@interface MapVC ()
{
    AppDelegate *objapp;
    CLLocationCoordinate2D location;
    GMSMutablePath *_path2,*Orignalpath;
    GMSPolyline *_polylineGreen;
    NSMutableArray *arrayPolylineGreen;
    int ind;
}
@end

@implementation MapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    objapp=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    location=CLLocationCoordinate2DMake(23.0225,72.5714);
    _path2 = [[GMSMutablePath alloc]init];
    
    GMSCameraPosition *camera=[GMSCameraPosition cameraWithTarget:location zoom:13.0 bearing:0.0 viewingAngle:0.0];
    map=[GMSMapView mapWithFrame:CGRectMake(0, 64.0, self.view.frame.size.width,self.view.frame.size.height-64.0) camera:camera];
    map.mapType=kGMSTypeHybrid;
    map.delegate=self;
    map.myLocationEnabled=TRUE;
    
    for(int i=0;i<[objapp.polyline count];i++)
    {
        NSString *encodedStr=[NSString stringWithFormat:@"%@",[objapp.polyline objectAtIndex:i]];
        Orignalpath = [GMSMutablePath pathFromEncodedPath:encodedStr];
        GMSPolyline *rectangle = [GMSPolyline polylineWithPath:Orignalpath];
        [rectangle setTappable:TRUE];
        UIColor *col=[UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1.0];
        
        rectangle.strokeColor=col;
        NSLog(@"Color %@",col);
        rectangle.strokeWidth=5.0;
        rectangle.map = map;
//        [self animate:Orignalpath];
        
    }
    
    

    [self.view addSubview:map];
//    [NSTimer scheduledTimerWithTimeInterval:0.003 repeats:true block:^(NSTimer * _Nonnull timer) {
//        [self animate:Orignalpath];
//    }];
    [self addPin];
   
}



-(void)mapView:(GMSMapView *)mapView didTapOverlay:(GMSOverlay *)overlay
{
    //save tapped overlay
    GMSOverlay *selectedOverlay=overlay;
    
    // clear other paths
    [map clear];
    selectedOverlay.map=map;
    
}




- (BOOL) didTapMyLocationButtonForMapView:(GMSMapView *)mapView
{
    return true;
}

-(void)addPin
{
//     GMSProjection *projection=[[GMSProjection alloc] ini]
    for (int lat=0; lat<1000; lat++)
    {
        CGFloat lt=location.latitude+(1.0*lat);
//        CGFloat lg=location.longitude+(0.20);
        GMSMarker *sourcePin=[GMSMarker markerWithPosition:CLLocationCoordinate2DMake(lt,location.longitude)];
        sourcePin.title=@"Source";
        sourcePin.snippet=@"T1";
        sourcePin.groundAnchor=CGPointMake(1.0, 1.0);
        
        if([map.projection containsCoordinate:sourcePin.position]==TRUE)
            sourcePin.map=map;
        else
            NSLog(@"remove");
    }
    
    
    NSLog(@"far left lat=%f long=%f",map.projection.visibleRegion.farLeft.latitude,map.projection.visibleRegion.farLeft.longitude);
    NSLog(@"far right lat=%f long=%f",map.projection.visibleRegion.farRight.latitude,map.projection.visibleRegion.farRight.longitude);
    NSLog(@"near left lat=%f long=%f",map.projection.visibleRegion.nearLeft.latitude,map.projection.visibleRegion.nearLeft.longitude);
    NSLog(@"near right lat=%f long=%f",map.projection.visibleRegion.nearRight.latitude,map.projection.visibleRegion.nearRight.longitude);
    

    GMSMarker *destinationPin=[GMSMarker markerWithPosition:CLLocationCoordinate2DMake(23.0191,72.5517)];
    destinationPin.title=@"Destination";
    destinationPin.snippet=@"T1";
    destinationPin.groundAnchor=CGPointMake(1.0, 1.0);
    
    destinationPin.map=map;
    
//    map
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
