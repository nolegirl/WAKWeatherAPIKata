//
//  WAKWeatherService.h
//  WeatherApiKata
//
//  Created by Detroit Labs User on 6/9/14.
//  Copyright (c) 2014 SieglitzMechelle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface WAKWeatherService : NSObject

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

- (void)getCurrentTemperature:(void (^)(NSInteger))successBlock;

@end
