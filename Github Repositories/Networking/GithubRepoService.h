//
//  GithubRepoService.h
//  Github Repositories
//
//  Created by Mohamed Fawzy on 10/2/20.
//  Copyright © 2020 fuzzix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RepoServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface GithubRepoService : NSObject<RepoServiceProtocol>

+(GithubRepoService *)serviceWithBaseURL:(NSString *)urlString;
-(void)getRepositories:(int)page limit:(int)limit compeletion:(Compeletion)compeletionBlock;
-(void)getInfo:(Compeletion)compeletionBlock;

@end

NS_ASSUME_NONNULL_END
