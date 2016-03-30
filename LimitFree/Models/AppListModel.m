//
//  AppListModel.m
//  LimitFree
//
//  Created by 千锋 on 16/3/30.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "AppListModel.h"

@implementation AppListModel

+ (NSDictionary *)modelContainerPropertyGenericClass{

    return @{@"applications":[ApplicationsModel class]};
}


@end

@implementation ApplicationsModel

+(NSDictionary *)modelCustomPropertyMapper{

    return @{@"desc":@"description"};
}

@end


