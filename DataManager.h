//
//  DataManager.h
//  ChuckNorrisFacts
//
//  Created by Michael Dawson
//  Copyright (c) 2010 Nippysaurus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Fact.h"

@interface DataManager : NSObject {

	NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;

}

@property (nonatomic, retain) IBOutlet NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain) IBOutlet NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) IBOutlet NSPersistentStoreCoordinator *persistentStoreCoordinator;

// singleton access
+ (DataManager*)sharedManager;

// configure the CoreData management objects
- (void)configureManagedObjectContext;

// create the initial data (first time app is run)
//-(void)createFactsInContext;

// add single fact
//+(void)addFact:(NSString*)fact toContext:(NSManagedObjectContext*)moc;

// retrieve the fact associated with id
+ (Fact*)getFactWithId:(NSInteger)id;

// number of facts
+ (NSInteger)numberOfFacts;

// number of facts which are marked as favorited
//+ (NSInteger)numberOfFavoriteFacts;

// id's of facts which are marked as favorites
//- (NSArray*)idOfFavorites;

// persist all data
- (void)persistData;

@end
