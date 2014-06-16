//
//  WAKWeatherServiceSpec.m
//  WeatherApiKata
//
//  Created by Detroit Labs User on 6/9/14.
//  Copyright (c) 2014 SieglitzMechelle. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import "WAKWeatherService.h"
#import <AFNetworking/AFNetworking.h>

SPEC_BEGIN(WAKWeatherServiceSpec)

    describe(@"WAKWeatherService", ^{
        __block WAKWeatherService *weatherService;
        
        beforeEach(^{
            weatherService = [[WAKWeatherService alloc] init];
        });
        
        it(@"Should have a getCurrentTemperature", ^{
            [[weatherService should] respondToSelector:@selector(getCurrentTemperature:)];
        });
        it(@"has an AFHTTPRequestOperationManager property", ^{
            [[weatherService.manager should] beKindOfClass:[AFHTTPRequestOperationManager class]];
        });
        
        context(@"When getCurrentTemperature method is called", ^{
                it(@"Should receive the correct current temperature", ^{
                    
                    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                        return [[request.URL absoluteString] isEqualToString:@"http://api.wunderground.com/api/9e456171e8c63964/conditions/q/MI/Detroit.json"];
                    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
                        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"testresponse.json", nil) statusCode:200 headers:@{@"Content-Type":@"text/json"}];
                    }];
                    
                    __block NSInteger reportedValue;
                    void (^blockThatReportsTemperature)(NSInteger) = ^(NSInteger currentTemperature) {
                        reportedValue = currentTemperature;
                    };
                    
                    [weatherService getCurrentTemperature:blockThatReportsTemperature];
                    
                    NSInteger temperatureReportedByOHHTTPStub = 64.4;
                    
                    [[expectFutureValue(theValue(reportedValue)) shouldEventuallyBeforeTimingOutAfter(1.0)] equal:theValue(temperatureReportedByOHHTTPStub)];

        });
    });
});

SPEC_END