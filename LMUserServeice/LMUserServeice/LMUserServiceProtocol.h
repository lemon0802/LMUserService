//
//  LMUserServiceProtocol.h
//  LMUserServeice
//
//  Created by KADFWJ on 2018/3/7.
//  Copyright © 2018年 KAD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BeeHive/BHServiceProtocol.h>
@protocol LMUserServiceProtocol <NSObject,BHServiceProtocol>

-(void) userData:(NSDictionary *) data;

@end
