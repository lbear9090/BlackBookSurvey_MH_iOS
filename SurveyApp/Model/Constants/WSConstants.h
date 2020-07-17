//
//  WSConstants.h
//  SurveyApp
//
//  Created by C111 on 10/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#ifndef WSConstants_h
#define WSConstants_h

#include "WebServiceConnector.h"
#include "WebServiceDataAdaptor.h"
#include "WebServiceResponse.h"

#include "Vendors.h"
#include "SurveyType.h"
#include "OrganizationType.h"
#include "Roles.h"
#include "Rating.h"

#include "ScoreMatrix.h"
#include "Preferences.h"

#include "Questions.h"

#define SERVER_URL @"http://s618129727.onlinehome.us/blackbooksurvey/api/Webservice.php"

#define WSGetPredefinedData             [NSString stringWithFormat:@"%@?Service=getPredefinedData", SERVER_URL]
#define WSGetSurveyType                 [NSString stringWithFormat:@"%@?Service=getSurveyType", SERVER_URL]
#define WSGetVendors                    [NSString stringWithFormat:@"%@?Service=getVendors", SERVER_URL]
#define WSGetOrganizationType           [NSString stringWithFormat:@"%@?Service=getOrganizationType", SERVER_URL]
#define WSGetRoles                      [NSString stringWithFormat:@"%@?Service=getRoles", SERVER_URL]

#define WSGetRating                      [NSString stringWithFormat:@"%@?Service=getRating", SERVER_URL]

#define WSGetQuestions                  [NSString stringWithFormat:@"%@?Service=getQuestions", SERVER_URL]
#define WSGetKeyQuestions               [NSString stringWithFormat:@"%@?Service=getKeyQuestions", SERVER_URL]
#define WSGetLoyaltyQuestions           [NSString stringWithFormat:@"%@?Service=getLoyaltyQuestions", SERVER_URL]
#define WSGetScoreMatrix                [NSString stringWithFormat:@"%@?Service=getScoreMatrix", SERVER_URL]
#define WSGetQuestionsForSurveyType     [NSString stringWithFormat:@"%@?Service=getQuestionsForSurveyType", SERVER_URL]
#define WSGetPreferences                [NSString stringWithFormat:@"%@?Service=getPreferences", SERVER_URL]

#define WSSetSurveyStatisticsForUser    [NSString stringWithFormat:@"%@?Service=setSurveyStatisticsForUser", SERVER_URL]
#define WSSetSurveyStatistics           [NSString stringWithFormat:@"%@?Service=setSurveyStatistics", SERVER_URL]
#define WSSetProfile                    [NSString stringWithFormat:@"%@?Service=setProfile", SERVER_URL]

#define WSCheckExistingUser             [NSString stringWithFormat:@"%@?Service=CheckExistingUser", SERVER_URL]

#define SurveyTypeClass @"SurveyType"
#define SurveyTypeEntity @"CDSurveyType"
#define SurveyTypeKey @"SurveyType"

#define VendorsClass @"Vendors"
#define VendorsEntity @"CDVendors"
#define VendorsKey @"Vendors"

#define OrganizationTypeClass @"OrganizationType"
#define OrganizationTypeEntity @"CDOrganizationType"
#define OrganizationTypeKey @"OrganizationType"

#define RolesClass @"Roles"
#define RolesEntity @"CDRoles"
#define RolesKey @"Roles"

#define RatingClass @"Rating"
#define RatingEntity @"CDRating"
#define RatingKey @"Rates"

#define ScoreMatrixClass @"ScoreMatrix"
#define ScoreMatrixEntity @"CDScoreMatrix"
#define ScoreMatrixKey @"ScoreMatrix"

#define PreferencesClass @"Preferences"
#define PreferencesEntity @"CDPreferences"
#define PreferencesKey @"Preferences"

#define QuestionsClass @"Questions"
#define QuestionsEntity @"CDQuestions"
#define QuestionsKey @"Questions"

#define isService(key)  [requestURL isEqualToString:key]

#endif /* WSConstants_h */
