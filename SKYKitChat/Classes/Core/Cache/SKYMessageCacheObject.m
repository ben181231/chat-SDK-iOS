//
//  SKYMessageCacheObject.m
//  SKYKitChat
//
//  Copyright 2016 Oursky Ltd.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "SKYMessageCacheObject.h"

@implementation SKYMessageCacheObject

+ (NSString *)primaryKey
{
    return @"recordID";
}

@end

@implementation SKYMessageCacheObject (SKYRecord)

- (SKYMessage *)messageRecord
{
    SKYRecordID *recordID = [SKYRecordID recordIDWithRecordType:@"message" name:self.recordID];
    SKYRecord *record = [[SKYRecord alloc] initWithRecordID:recordID data:@{}];
    SKYMessage *message = [SKYMessage recordWithRecord:record];
    message.conversationRef = [SKYReference
        referenceWithRecordID:[SKYRecordID recordIDWithRecordType:@"conversation"
                                                             name:self.conversationID]];
    return message;
}

+ (SKYMessageCacheObject *)cacheObjectFromMessage:(SKYMessage *)message
{
    SKYMessageCacheObject *cacheObject = [[SKYMessageCacheObject alloc] init];

    cacheObject.recordID = message.recordID.recordName;
    cacheObject.conversationID = message.conversationRef.recordID.recordName;
    cacheObject.creationDate = message.record.creationDate;

    return cacheObject;
}

@end
