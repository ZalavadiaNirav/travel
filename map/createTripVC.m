//
//  ViewController.m
//  map
//
//  Created by Nirav Zalavadia on 26/06/17.
//  Copyright © 2017 CNSoftNet. All rights reserved.
//

#import "createTripVC.h"
#import "MKPolyline+MKPolyline_EncodedString.h"

@interface createTripVC ()

@end

@implementation createTripVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    objapp=(AppDelegate *)[[UIApplication sharedApplication] delegate];
   routesArr=[[NSMutableArray alloc] init];
    
}

- (IBAction)startTripAction:(id)sender
{
//    23.0225,72.5714  23.0191, 72.5517
    //call direction api
    
     NSString *urlStr=@"http://maps.googleapis.com/maps/api/directions/json?origin=23.0225,72.5714&destination=22.3039,70.8022&units=metric&alternatives=true";
    
//    NSString *urlStr=@"http://maps.googleapis.com/maps/api/directions/json?origin=22.0225,73.5714&destination=25.3039,70.8022&units=metric&alternatives=true";
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        NSError *err=nil;

        NSDictionary *tempDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:(&err)];
        routesArr=[[tempDict objectForKey:@"routes"] mutableCopy];
        NSLog(@"Data received %@",[tempDict description]);
        
       
      

        [self saveIntoDb];
        
    }];
    [task resume];
}

-(void)saveIntoDb
{
    distanceStr=[[NSMutableString alloc] init];
    durationStr=[[NSMutableString alloc] init];
    NSMutableString *path=[[NSMutableString alloc] init];

    for(int i=0;i<[routesArr count];i++)
    {
        NSArray *legsArr=[[routesArr objectAtIndex:i] objectForKey:@"legs"];
        
        durationStr=[[durationStr stringByAppendingString:[NSString stringWithFormat:@"%@,",[[[legsArr objectAtIndex:0] objectForKey:@"duration"] objectForKey:@"text"]]] mutableCopy];
        
        distanceStr=[[distanceStr stringByAppendingString:[NSString stringWithFormat:@"%@,",[[[legsArr objectAtIndex:0] objectForKey:@"distance"] objectForKey:@"text"]]] mutableCopy];
        
         objapp.coordinateArr=[[NSMutableArray alloc] init];
        
        [objapp.polyline addObject:[NSString stringWithFormat:@"%@",[[[routesArr objectAtIndex:i] objectForKey:@"overview_polyline"] objectForKey:@"points"]]];
        [MKPolyline polylineWithEncodedString:[NSString stringWithFormat:@"%@",[[[routesArr objectAtIndex:i] objectForKey:@"overview_polyline"] objectForKey:@"points"]]];
//        if([path length]>0)
//            path=[[path stringByAppendingString:path] mutableCopy];
        
        NSString *newpath=[NSString stringWithFormat:@"[%@]",[objapp.coordinateArr componentsJoinedByString:@","]];
        path=[[path stringByAppendingString:newpath] mutableCopy];
        NSLog(@"all paths %@",path);
    }
    
   
    NSString *insertQuery=[NSString stringWithFormat:@"insert into trip values ('source','destination','%@','%@','%@')",durationStr,distanceStr,path];

    [objapp.objsk performSQL:insertQuery];
    
    NSLog(@"Insert Query %@",insertQuery);
    UIAlertController *successMsg=[UIAlertController alertControllerWithTitle:@"Successfully" message:@"Data inserted Successfully" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [successMsg dismissViewControllerAnimated:YES completion:nil];
    }];
    [successMsg addAction:ok];
    [self presentViewController:successMsg animated:YES completion:nil];

}



/*

-(void)saveIntoDb
{
    // route (lat-lng)
    //create route1,route2
    // pathStr     generated string [(lat-lng),(),..],[(lat-lng),(),..],
    distanceStr=[[NSMutableString alloc] init];
    durationStr=[[NSMutableString alloc] init];
    pathStr=[[NSMutableString alloc] init];
    for(int i=0;i<[routesArr count];i++)
    {
        NSArray *legsArr=[[routesArr objectAtIndex:i] objectForKey:@"legs"];
        
        durationStr=[[durationStr stringByAppendingString:[NSString stringWithFormat:@"%@,",[[[legsArr objectAtIndex:0] objectForKey:@"duration"] objectForKey:@"text"]]] mutableCopy];
        
        distanceStr=[[distanceStr stringByAppendingString:[NSString stringWithFormat:@"%@,",[[[legsArr objectAtIndex:0] objectForKey:@"distance"] objectForKey:@"text"]]] mutableCopy];
        
        NSArray *stepsArr=[[legsArr objectAtIndex:0] objectForKey:@"steps"];
      
        pathStr=[[pathStr stringByAppendingString:@"["] mutableCopy];
        
        for (int n=0; n<[stepsArr count]; n++)
        {
            
            NSString *source=[NSString stringWithFormat:@"%@-%@",[[[stepsArr objectAtIndex:n] objectForKey:@"start_location"] objectForKey:@"lat"],[[[stepsArr objectAtIndex:n] objectForKey:@"start_location"] objectForKey:@"lng"]];
            
            NSString *desrination=[NSString stringWithFormat:@"%@-%@",[[[stepsArr objectAtIndex:n] objectForKey:@"end_location"] objectForKey:@"lat"],[[[stepsArr objectAtIndex:n] objectForKey:@"end_location"] objectForKey:@"lng"]];
            pathStr=[[pathStr stringByAppendingString:[NSString stringWithFormat:@"(%@,%@)",source,desrination]] mutableCopy];
        }
        pathStr=[[pathStr stringByAppendingString:@"],"] mutableCopy];
    }
    NSLog(@"pathStr %@",pathStr);
    
    NSString *insertQuery=[NSString stringWithFormat:@"insert into trip values ('source','destination','%@','%@','%@')",durationStr,distanceStr,pathStr];
    
    [objapp.objsk performSQL:insertQuery];
    
    NSLog(@"Insert Query %@",insertQuery);
    UIAlertController *successMsg=[UIAlertController alertControllerWithTitle:@"Successfully" message:@"Data inserted Successfully" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [successMsg dismissViewControllerAnimated:YES completion:nil];
    }];
    [successMsg addAction:ok];
    [self presentViewController:successMsg animated:YES completion:nil];
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
