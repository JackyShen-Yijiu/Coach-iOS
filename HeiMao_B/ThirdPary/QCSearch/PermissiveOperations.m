//
//  JMOScoringOperation.m
//  PermissiveSearch
//
//  Created by Jerome Morissard on 10/29/13.
//  Copyright (c) 2013 Jerome Morissard. All rights reserved.
//

#import "PermissiveOperations.h"
#import "PermissiveResearchDatabase.h"
#import "PermissiveObject.h"
#import "PermissiveAlignementMethods.h"
#import "PermissiveScoringMatrix.h"

@implementation ScoringOperationQueue

+ (ScoringOperationQueue *)mainQueue
{
    static ScoringOperationQueue *mainQueue = nil;
    if (mainQueue == nil)
    {
        mainQueue = [[ScoringOperationQueue alloc] init];
        mainQueue.maxConcurrentOperationCount = 1;
    }
    
    return mainQueue;
}

@end

@implementation ExactScoringOperation

#pragma mark -
#pragma mark - Main operation


- (BOOL)isConcurrent
{
    return NO;
}

- (void)main {
    
    @autoreleasepool {
        
        NSUInteger taille = self.searchedString.length;
        
        int max = (int)MAX([[[PermissiveResearchDatabase sharedDatabase].elements valueForKeyPath:@"@max.keyLenght"] intValue], [self.searchedString length]);
        int **alignementMatrix = allocate2D(max,max);
        
        JMOLog(@"1------ Searching %@ in %d elements", self.searchedString,(int)[PermissiveResearchDatabase sharedDatabase].elements.count);
        
        [[PermissiveResearchDatabase sharedDatabase].elements enumerateObjectsUsingBlock:^(PermissiveObject *obj, BOOL *stop) {
            if (self.isCancelled)
                return;
            obj.score = score2Strings(self.searchedString.UTF8String, obj.key, taille, obj.keyLenght,alignementMatrix, 0);
            
        }];
        
        if (self.isCancelled)
            return;
        
        JMOLog(@"1---------Searching -> Done ");
        NSLog(@"1--------self.searchedString.length:%lu",self.searchedString.length);
        
        //Sorting
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"score" ascending:NO];
        
        NSArray *findedElements = [[[PermissiveResearchDatabase sharedDatabase].elements sortedArrayUsingDescriptors:@[sortDescriptor]] subarrayWithRange:NSMakeRange(0, self.searchedString.length)];
        NSLog(@"1--------findedElements.count:%lu",findedElements.count);
        
        //LOG MAX
        if (findedElements && findedElements.count>0) {
            
            PermissiveObject *obj = [findedElements objectAtIndex:0];
            logCalculatedMatrix([self.searchedString UTF8String], obj.key, (int)taille, obj.keyLenght);
            
        }
        if(self.customCompletionBlock) {
            self.customCompletionBlock(findedElements);
        }
        
    }
}


@end


@implementation HeuristicScoringOperation

#pragma mark -
#pragma mark - Main operation


- (BOOL)isConcurrent
{
    return NO;
}

- (void)main {
    @autoreleasepool {
        
        if (self.searchedString.length < ScoringSegmentLenght) {
            if(self.customCompletionBlock) {
                JMOLog(@"Search operation aborded, search operation need more letters");
                self.customCompletionBlock(nil);
            }
            return;
        }
        
        JMOLog(@"2----------Searching %@ in %d elements", self.searchedString,(int)[PermissiveResearchDatabase sharedDatabase].elements.count);
        [[PermissiveResearchDatabase sharedDatabase].elements enumerateObjectsUsingBlock:^(PermissiveObject *obj, BOOL *stop) {
            obj.score = 0;
        }];
        
        for (int i = 0; i <= self.searchedString.length - ScoringSegmentLenght; i++) {
            NSString *segment = [self.searchedString substringWithRange:NSMakeRange(i, ScoringSegmentLenght)];
            [[[PermissiveResearchDatabase sharedDatabase] objectsForSegment:segment] enumerateObjectsUsingBlock:^(PermissiveObject *obj, BOOL *stop) {
                obj.score++;
            }];
        }
        
        if (self.isCancelled)
            return;
        
        JMOLog(@"2--------Searching -> Done ");
        
        //Sorting
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"score" ascending:NO];
        NSArray *findedElements = [[[PermissiveResearchDatabase sharedDatabase].elements sortedArrayUsingDescriptors:@[sortDescriptor]] subarrayWithRange:NSMakeRange(0, self.searchedString.length)];
        
        NSLog(@"2---------findedElements.count:%lu",findedElements.count);
        NSLog(@"2--------self.searchedString.length:%lu",self.searchedString.length);

        //LOG MAX
        NSUInteger taille = self.searchedString.length;
        if (findedElements && findedElements.count>0) {
            
            PermissiveObject *obj = [findedElements objectAtIndex:0];
            logCalculatedMatrix([self.searchedString UTF8String], obj.key, (int)taille, obj.keyLenght);
            
        }
        if(self.customCompletionBlock) {
            self.customCompletionBlock(findedElements);
        }
        
    }
}
@end



@implementation HeurexactScoringOperation

#pragma mark -
#pragma mark - Main operation


- (BOOL)isConcurrent
{
    return NO;
}

- (void)main {
    @autoreleasepool {
        
        if (self.searchedString.length < ScoringSegmentLenght) {
            if(self.customCompletionBlock) {
                self.customCompletionBlock(nil);
            }
            return;
        }
        
        JMOLog(@"3---------Searching %@ in %d elements", self.searchedString,(int)[PermissiveResearchDatabase sharedDatabase].elements.count);
        [[PermissiveResearchDatabase sharedDatabase].elements enumerateObjectsUsingBlock:^(PermissiveObject *obj, BOOL *stop) {
            obj.score = 0;
        }];
        
        for (int i = 0; i < self.searchedString.length - ScoringSegmentLenght; i++) {
            NSString *segment = [self.searchedString substringWithRange:NSMakeRange(i, ScoringSegmentLenght)];
            [[[PermissiveResearchDatabase sharedDatabase] objectsForSegment:segment] enumerateObjectsUsingBlock:^(PermissiveObject *obj, BOOL *stop) {
                obj.score++;
            }];
        }
        
        if (self.isCancelled)
            return;
        
        JMOLog(@"3---------Searching -> Done ");
        
        
        JMOLog(@"3---------Start adjusting -> Done ");
        
        //Sorting
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"score" ascending:NO];
        NSArray *arrayOfElemets = [[PermissiveResearchDatabase sharedDatabase].elements sortedArrayUsingDescriptors:@[sortDescriptor]];
        
        NSUInteger taille = self.searchedString.length;
        int max = (int)MAX([[[PermissiveResearchDatabase sharedDatabase].elements valueForKeyPath:@"@max.keyLenght"] intValue], [self.searchedString length]);
        int **alignementMatrix = allocate2D(max,max);
        
        [arrayOfElemets enumerateObjectsUsingBlock:^(PermissiveObject *obj, NSUInteger idx, BOOL *stop) {
            if (self.isCancelled)
                return;
            
            if (idx == 50) {
                *stop = YES;
            }
            
            obj.score = score2Strings(self.searchedString.UTF8String, obj.key, taille, obj.keyLenght,alignementMatrix, 0);
            
        }];
        
        NSArray *findedElements = [[arrayOfElemets sortedArrayUsingDescriptors:@[sortDescriptor]] subarrayWithRange:NSMakeRange(0, self.searchedString.length)];
        
        NSLog(@"3-----------findedElements.count:%lu",findedElements.count);
        NSLog(@"3--------self.searchedString.length:%lu",self.searchedString.length);

        if (findedElements && findedElements.count>0) {
            
            //LOG MAX
            PermissiveObject *obj = [findedElements objectAtIndex:0];
            logCalculatedMatrix([self.searchedString UTF8String], obj.key, (int)taille, obj.keyLenght);
            
        }
        if(self.customCompletionBlock) {
            self.customCompletionBlock(findedElements);
        }
    }
}

@end

