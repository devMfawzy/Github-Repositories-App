//
//  RepoServiceProtocol.h
//  Github Repositories
//
//  Created by Mohamed Fawzy on 10/3/20.
//  Copyright © 2020 fuzzix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^Compeletion)(NSData * _Nullable data, NSError * _Nullable error);

@protocol RepoServiceProtocol

-(void)getRepositories:(int)page limit:(int)limit compeletion:(Compeletion)compeletionBlock;
-(void)getInfo:(Compeletion)compeletionBlock;

@end

NS_ASSUME_NONNULL_END
