//
//  DriverStatusVC.m
//  map
//
//  Created by Nirav Zalavadia on 27/06/17.
//  Copyright © 2017 CNSoftNet. All rights reserved.
//

#import "DriverStatusVC.h"

@interface DriverStatusVC ()

@end

@implementation DriverStatusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    objapp=(AppDelegate *)[[UIApplication sharedApplication] delegate];
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

-(void)getPathsfromDb
{
    NSArray *allData=[objapp.objsk lookupAllForSQL:@"select * from trip"];
     NSArray *distanceArr=[[NSString stringWithFormat:@"%@",[[allData objectAtIndex:0] objectForKey:@"distance"]] componentsSeparatedByString:@","];
     NSArray *durationArr=[[NSString stringWithFormat:@"%@",[[allData objectAtIndex:0] objectForKey:@"duration"]] componentsSeparatedByString:@","];
    for (int i=0; i<[allData count]; i++)
    {
        availablePaths =[[[allData objectAtIndex:i] objectForKey:@"path"] componentsSeparatedByString:@"]"];
    }
    NSLog(@"distancearr %@ durationarray %@ paths %@",distanceArr,durationArr,availablePaths);
}

- (IBAction)viewOnMapAction:(id)sender {
}

- (IBAction)checkPositionAction:(id)sender
{
    NSString *searchCoordinate=[NSString stringWithFormat:@"%@-%@",_travelerLatTxt.text,_travelerLongTxt.text];
    [self getPathsfromDb];
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchCoordinate]; // if you need case sensitive search avoid '[c]' in the predicate
    
    NSArray *results = [availablePaths filteredArrayUsingPredicate:predicate];
    
    NSLog(@"results %@",results);
    
   
    if([results count]>0)
    {
        _statusLbl.text=[NSString stringWithFormat:@"Travaler is in route"];
    }
    else
        _statusLbl.text=[NSString stringWithFormat:@"Traveler is out of track"];
}
@end
