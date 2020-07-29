//
//  Constants.h
//  SurveyApp
//
//  Created by C111 on 08/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#import "SVProgressHUD.h"

#define kHasLaunchedOnce @"hasLaunchedOnce"
#define kFirstRun @"firstRun"

#define kDeviceType @"iOS"

#define kFacebookID @"facebookID"

#define kIsEditingProfile @"isEditingProfile"
#define kComingFromLogin @"comingFromLogin"

#define kUID @"uid"
#define kFBID @"fbid"
#define kUserName @"userName"
#define kEmail @"email"
#define kPhone @"phone"
#define kUserLoggedIn @"userLoggedIn"

#define kIsFacebookLogin @"isFacebookLogin"
#define kIsGoogleLogin @"isGoogleLogin"
#define kIsTwitterLogin @"isTwitterLogin"
#define kIsLinkedinLogin @"isLinkedinLogin"

#define kSurveyID @"surveyID"
#define kSurveyName @"surveyName"

#define kVendors @"Vendors"
#define kVendorsParsed @"vendorsParsed"

#define kServices @"Services"
#define kServicesParsed @"servicesParsed"

#define kOrganizations @"Organizations"
#define kOrganizationsParsed @"organizationsParsed"

#define kRoles @"Roles"
#define kRolesParsed @"rolesParsed"

#define kRating @"Rating"
#define kRatingParsed @"ratingParsed"


#define kPreferences @"Preferences"
#define kPreferencesParsed @"preferencesParsed"

#define kScoreMatrix @"ScoreMatrix"
#define kScoreMatrixParsed @"scoreMatrixParsed"

#define kQuestions @"Questions"
#define kQuestionsParsed @"questionsParsed"

#define kSelectedVendor @"selectedVendors"
#define kSelectedServices @"selectedServices"
#define kSelectedOrganizations @"selectedOrganizations"
#define kSelectedRoles @"selectedRoles"
#define kSelectedRatings @"selectedRatings"

#define kOtherOrgaizationTitle @"otherOrganizationTitle"

#define kSelectedVendorID @"selectedVendorsID"
#define kSelectedServicesID @"selectedServicesID"
#define kSelectedOrganizationsID @"selectedOrganizationsID"
#define kSelectedRolesID @"selectedRolesID"
#define kSelectedRatingID @"selectedRatingID"

#define kRenew @"renew"
#define kRecommend @"recommend"
#define kBuyMore @"buy"

#define kNotice @"notice"
#define kIncentives @"incentives"
#define kFuture @"future"

#define kScoreMatrixID @"scoreMatrixID"

#define kIssueWithServer @"There's some issue with Server. Please try again after sometime"

#define SFUITextLight(fontSize)     [UIFont fontWithName:@"SFUIText-Light" size:fontSize]
#define SFUITextMedium(fontSize)    [UIFont fontWithName:@"SFUIText-Medium" size:fontSize]
#define SFUITextRegular(fontSize)   [UIFont fontWithName:@"SFUIText-Regular" size:fontSize]
#define SFUITextBold(fontSize)      [UIFont fontWithName:@"SFUIText-Bold" size:fontSize]
#define SFUITextHeavy(fontSize)     [UIFont fontWithName:@"SFUIText-Heavy" size:fontSize]
#define SFUITextSemibold(fontSize)  [UIFont fontWithName:@"SFUIText-Semibold" size:fontSize]

#define TimeStamp                   [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970] * 1000]
#define Between(value, min, max)    (value <= max && value >= min)
#define RGB(R, G, B)                [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

#define kComingFrom @"comingFrom"

#define kComingFromService          @"comingFromService"
#define kComingFromOrganization     @"comingFromOrganization"
#define kComingFromRole             @"comingFromRole"
#define kComingFromRting             @"comingFromRating"

#define kVendorsURL         @"http://blackbookmarketresearch.com/directory"
#define kScoringKeyURL      @"http://blackbookmarketresearch.com/methodology#qualitative"

#define LINKEDIN_CLIENT_ID @"869zacejh2bxzp"
#define LINKEDIN_CLIENT_SECRET @"Lrlt7tsbB67DZg38"
#define TWITTER_CONSUMER_API_KEY @"EePRG9I4O4XC6veJivfAN3sHi"
#define TWITTER_CONSUMER_API_SECRET_KEY @"kSkjfdC3sc3FWlzVYkEsYbsLhUa99H2q0Fsg4hsQz3OcrAZwNh"
#endif /* Constants_h */
