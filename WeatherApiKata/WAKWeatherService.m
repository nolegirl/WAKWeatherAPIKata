//
//  WAKWeatherService.m
//  WeatherApiKata
//
//  Created by Detroit Labs User on 6/9/14.
//  Copyright (c) 2014 SieglitzMechelle. All rights reserved.
//

#import "WAKWeatherService.h"

@implementation WAKWeatherService

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.manager = [[AFHTTPRequestOperationManager alloc] init];
    }
    return self;
}


- (void)getCurrentTemperature:(void (^)(NSInteger))successBlock {
    void(^newSuccessBlock)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSNumber *temperatureObject = (NSNumber *)responseObject[@"current_observation"][@"temp_f"];
        NSInteger currentTemperature = [temperatureObject integerValue];
        successBlock(currentTemperature);
    };
    [self.manager GET:@"http://api.wunderground.com/api/9e456171e8c63964/conditions/q/MI/Detroit.json"
           parameters:nil
              success:newSuccessBlock
              failure:nil];
}

@end
