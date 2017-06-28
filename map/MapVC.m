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
    
    for(int i=0;i<[objapp.polyline count];i++)
    {
        NSString *encodedStr=[NSString stringWithFormat:@"%@",[objapp.polyline objectAtIndex:i]];
        Orignalpath = [GMSMutablePath pathFromEncodedPath:encodedStr];
        GMSPolyline *rectangle = [GMSPolyline polylineWithPath:Orignalpath];
        
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

//-(void)animate:(GMSPath *)path {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if (ind < path.count) {
//            [_path2 addCoordinate:[path coordinateAtIndex:ind]];
//            _polylineGreen = [GMSPolyline polylineWithPath:_path2];
//            _polylineGreen.strokeColor = [UIColor greenColor];
//            _polylineGreen.strokeWidth = 3;
//            _polylineGreen.map = map;
//            [arrayPolylineGreen addObject:_polylineGreen];
//            ind++;
//        }
//        else {
//            ind = 0;
//            _path2 = [[GMSMutablePath alloc] init];
//            
//            for (GMSPolyline *line in arrayPolylineGreen) {
//                line.map = nil;
//            }
//            
//        }
//    });
//}


-(void)addPin
{
    GMSMarker *sourcePin=[GMSMarker markerWithPosition:location];
    sourcePin.title=@"Source";
    sourcePin.snippet=@"T1";
    sourcePin.groundAnchor=CGPointMake(1.0, 1.0);
    
    GMSMarker *destinationPin=[GMSMarker markerWithPosition:CLLocationCoordinate2DMake(23.0191,72.5517)];
    destinationPin.title=@"Destination";
    destinationPin.snippet=@"T1";
    destinationPin.groundAnchor=CGPointMake(1.0, 1.0);
    
    sourcePin.map=map;
    destinationPin.map=map;
    
    
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
