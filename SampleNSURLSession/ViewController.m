//
//  ViewController.m
//  SampleNSURLSession
//
//  Created by Keita on 1/28/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLSessionDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *urlString = @"https://graph.facebook.com/name-of-your-page-here";
    // Replace the above url with name of your page.
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                if (error != nil) {
                                                    // If any error occurs then just display its description on the console.
                                                    NSLog(@"%@", [error localizedDescription]);
                                                } else {
                                                    // If no error occurs, check the HTTP status code.
                                                    NSInteger HTTPStatusCode = [(NSHTTPURLResponse *)response statusCode];
                                                    
                                                    // If it's other than 200, then show it on the console.
                                                    if (HTTPStatusCode != 200) {
                                                        NSLog(@"HTTP status code = %ld", (long)HTTPStatusCode);
                                                    }
                                                    NSLog(@"\n%@\n", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                                }
                                            }];
    
    [dataTask resume];
    
    NSLog(@"Finished viewDidLoad");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
