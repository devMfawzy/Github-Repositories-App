//
//  GithubRepoService.m
//  Github Repositories
//
//  Created by Mohamed Fawzy on 10/2/20.
//  Copyright © 2020 fuzzix. All rights reserved.
//

#import "GithubRepoService.h"

#define SinceKey @"since"
#define PerPageKey @"per_page"

@interface GithubRepoService()
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSString *baseURL;
@end

@implementation GithubRepoService

+(GithubRepoService *)serviceWithBaseURL:(NSString *)urlString {
    GithubRepoService *newInstancetype = [GithubRepoService new];
    if(newInstancetype) {
        newInstancetype.baseURL = urlString;
        newInstancetype.session = [NSURLSession sharedSession];
    }
    return newInstancetype;
}

-(void)getRepositories:(int)page limit:(int)limit compeletion:(Compeletion)compeletionBlock {
    NSURL * url = [self urlOfRepositoriesInPage:page limit:limit];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self perfromDataTask:urlRequest compeletion:compeletionBlock];
}

-(void)getInfo:(Compeletion)compeletionBlock {
    NSURL *url = [NSURL URLWithString:_baseURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self perfromDataTask:urlRequest compeletion:compeletionBlock];
}

-(void)perfromDataTask:(NSURLRequest *)urlRequest compeletion:(Compeletion)compeletionBlock {
    NSURLSessionDataTask *dataTask = [_session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            compeletionBlock(data,error);
        });
    }];
    [dataTask resume];
}

-(NSURL *)urlOfRepositoriesInPage:(int)page limit:(int)limit {
    NSString *pageString = [NSString stringWithFormat:@"%i",page];
    NSString *limitString = [NSString stringWithFormat:@"%i",limit];
    NSURLQueryItem *pageQueryItem = [NSURLQueryItem queryItemWithName: SinceKey value:pageString];
    NSURLQueryItem *limitQueryItem = [NSURLQueryItem queryItemWithName: PerPageKey value:limitString];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:_baseURL];
    urlComponents.queryItems = @[pageQueryItem,limitQueryItem];
    return urlComponents.URL;
}

@end
