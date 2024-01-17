## 100007281-PredictiveScoring-PSMain

**Name** (not equal to External Key)**:** CTCA Shared Services, Inc.-10078-100007281-PSMain

**Description:** This automation sends CURRENT data to the Data Scientists for scoring and is an important componentof the Einstein Engagement Scoring application.

**Folder:** my automations/Data Factory Utility Automations/

**Started by:** Schedule

**Status:** Scheduled

**Schedule:**

* Start: 2018-01-15 11:06:30.77 -06:00
* End: 2097-12-25 11:06:30 -06:00
* Timezone: Central Standard Time (no DST)
* Recurrance: every 24 hours for 29200 times

**Notifications:** _none_


| Step 1<br>_<small>Predictive Scoring extract-upload task #01</small>_ | Step 2<br>_<small>Predictive Scoring extract-upload task #02</small>_ | Step 3<br>_<small>Predictive Scoring extract-upload task #03</small>_ | Step 4<br>_<small>Predictive Scoring extract-upload task #04</small>_ | Step 5<br>_<small>Predictive Scoring extract-upload task #05</small>_ | Step 6<br>_<small>Predictive Scoring extract-upload task #06</small>_ | Step 7<br>_<small>Predictive Scoring extract-upload task #07</small>_ | Step 8<br>_<small>Predictive Scoring extract-upload task #08</small>_ | Step 9<br>_<small>Predictive Scoring extract-upload task #09</small>_ |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| _1.1: dataFactoryUtility_<br>Extract-Upload stats.Bounce into S3 | _2.1: dataFactoryUtility_<br>Extract-Upload Stats.RefererEmailClient into S3 | _3.1: dataFactoryUtility_<br>Extract-Upload C100007281._GeofenceDefinition into S3 | _4.1: dataFactoryUtility_<br>Extract-Upload C100007281.PSConfig into S3 | _5.1: dataFactoryUtility_<br>Extract-Upload C100007281._MobileMessage into S3 | _6.1: dataFactoryUtility_<br>Extract-Upload C100007281.SmsMemberSharedShortCode_Config into S3 | _7.1: dataFactoryUtility_<br>Extract-Upload dbo.EmailSendDefinition into S3 | _8.1: dataFactoryUtility_<br>Extract-Upload dbo.EnterpriseMember into S3 | _9.1: dataFactoryUtility_<br>Extract-Upload C100007281.VPS_ExportDone into S3 |
| _1.2: dataFactoryUtility_<br>Extract-Upload stats.BounceDecrementQueue into S3 | _2.2: dataFactoryUtility_<br>Extract-Upload stats.Send into S3 | _3.2: dataFactoryUtility_<br>Extract-Upload C100007281._MobileAddress into S3 | _4.2: dataFactoryUtility_<br>Extract-Upload dbo.ProgramActivityInstance into S3 | _5.2: dataFactoryUtility_<br>Extract-Upload C100010068._MobileMessage into S3 | _6.2: dataFactoryUtility_<br>Extract-Upload C100007281.SmsMemberShortCodeDistinct into S3 | _7.2: dataFactoryUtility_<br>Extract-Upload dbo.Send into S3 | _8.2: dataFactoryUtility_<br>Extract-Upload dbo.MemberTimeZone into S3 | - |
| _1.3: dataFactoryUtility_<br>Extract-Upload stats.Click into S3 | _2.3: dataFactoryUtility_<br>Extract-Upload Stats.UserAgentApplication into S3 | _3.3: dataFactoryUtility_<br>Extract-Upload C100007281._MobileMessageTracking into S3 | _4.3: dataFactoryUtility_<br>Extract-Upload dbo.ProgramInstance into S3 | _5.3: dataFactoryUtility_<br>Extract-Upload C100010091._MobileMessage into S3 | _6.3: dataFactoryUtility_<br>Extract-Upload C100010068.SmsMemberSharedShortCode_Config into S3 | _7.3: dataFactoryUtility_<br>Extract-Upload dbo.tblEmails into S3 | _8.3: dataFactoryUtility_<br>Extract-Upload dbo.SendDefType into S3 | - |
| _1.4: dataFactoryUtility_<br>Extract-Upload stats.Complaint into S3 | _2.4: dataFactoryUtility_<br>Extract-Upload Stats.UserAgentDevice into S3 | _3.4: dataFactoryUtility_<br>Extract-Upload C100007281._PushAddress into S3 | _4.4: dataFactoryUtility_<br>Extract-Upload InteractionStudio.Activity into S3 | _5.4: dataFactoryUtility_<br>Extract-Upload C100010094._MobileMessage into S3 | _6.4: dataFactoryUtility_<br>Extract-Upload C100010068.SmsMemberShortCodeDistinct into S3 | _7.4: dataFactoryUtility_<br>Extract-Upload dbo.tblLists into S3 | _8.4: dataFactoryUtility_<br>Extract-Upload dbo.tblMembers into S3 | - |
| _1.5: dataFactoryUtility_<br>Extract-Upload stats.Conversion into S3 | _2.5: dataFactoryUtility_<br>Extract-Upload Stats.UserAgentEmailClient into S3 | _3.5: dataFactoryUtility_<br>Extract-Upload C100007281._PushMessageAudience into S3 | _4.5: dataFactoryUtility_<br>Extract-Upload InteractionStudio.DefinitionInfo into S3 | _5.5: dataFactoryUtility_<br>Extract-Upload C100010601._MobileMessage into S3 | _6.5: dataFactoryUtility_<br>Extract-Upload C100010091.SmsMemberSharedShortCode_Config into S3 | - | _8.5: dataFactoryUtility_<br>Extract-Upload dbo.TimeZoneDetail into S3 | - |
| _1.6: dataFactoryUtility_<br>Extract-Upload stats.Open into S3 | _2.6: dataFactoryUtility_<br>Extract-Upload Stats.UserAgentOperatingSystem into S3 | _3.6: dataFactoryUtility_<br>Extract-Upload C100007281._PushMessageTracking into S3 | _4.6: dataFactoryUtility_<br>Extract-Upload InteractionStudio.EventDefinition into S3 | _5.6: dataFactoryUtility_<br>Extract-Upload C100011367._MobileMessage into S3 | _6.6: dataFactoryUtility_<br>Extract-Upload C100010091.SmsMemberShortCodeDistinct into S3 | - | - | - |
| _1.7: dataFactoryUtility_<br>Extract-Upload stats.Unsubscribe into S3 | - | _3.7: dataFactoryUtility_<br>Extract-Upload C100007281._PushSubscriptionHistory into S3 | _4.7: dataFactoryUtility_<br>Extract-Upload InteractionStudio.EventInstance into S3 | _5.7: dataFactoryUtility_<br>Extract-Upload C515013291._MobileMessage into S3 | _6.7: dataFactoryUtility_<br>Extract-Upload C100010094.SmsMemberSharedShortCode_Config into S3 | - | - | - |
| - | - | _3.8: dataFactoryUtility_<br>Extract-Upload C100007281._PushTag into S3 | - | _5.8: dataFactoryUtility_<br>Extract-Upload dbo.ABTestSend into S3 | _6.8: dataFactoryUtility_<br>Extract-Upload C100010094.SmsMemberShortCodeDistinct into S3 | - | - | - |
| - | - | _3.9: dataFactoryUtility_<br>Extract-Upload C100010068._GeofenceDefinition into S3 | - | _5.9: dataFactoryUtility_<br>Extract-Upload dbo.ABTestSendJob into S3 | _6.9: dataFactoryUtility_<br>Extract-Upload C100010601.SmsMemberSharedShortCode_Config into S3 | - | - | - |
| - | - | _3.10: dataFactoryUtility_<br>Extract-Upload C100010068._MobileAddress into S3 | - | _5.10: dataFactoryUtility_<br>Extract-Upload dbo.CampaignAsset into S3 | _6.10: dataFactoryUtility_<br>Extract-Upload C100010601.SmsMemberShortCodeDistinct into S3 | - | - | - |
| - | - | _3.11: dataFactoryUtility_<br>Extract-Upload C100010068._MobileMessageTracking into S3 | - | _5.11: dataFactoryUtility_<br>Extract-Upload dbo.CampaignAssetType into S3 | _6.11: dataFactoryUtility_<br>Extract-Upload C100011367.SmsMemberSharedShortCode_Config into S3 | - | - | - |
| - | - | _3.12: dataFactoryUtility_<br>Extract-Upload C100010068._PushAddress into S3 | - | _5.12: dataFactoryUtility_<br>Extract-Upload dbo.CustomObject into S3 | _6.12: dataFactoryUtility_<br>Extract-Upload C100011367.SmsMemberShortCodeDistinct into S3 | - | - | - |
| - | - | _3.13: dataFactoryUtility_<br>Extract-Upload C100010068._PushMessageAudience into S3 | - | _5.13: dataFactoryUtility_<br>Extract-Upload dbo.JobCampaignDefinition into S3 | _6.13: dataFactoryUtility_<br>Extract-Upload C515013291.SmsMemberSharedShortCode_Config into S3 | - | - | - |
| - | - | _3.14: dataFactoryUtility_<br>Extract-Upload C100010068._PushMessageTracking into S3 | - | _5.14: dataFactoryUtility_<br>Extract-Upload dbo.Program into S3 | _6.14: dataFactoryUtility_<br>Extract-Upload C515013291.SmsMemberShortCodeDistinct into S3 | - | - | - |
| - | - | _3.15: dataFactoryUtility_<br>Extract-Upload C100010068._PushSubscriptionHistory into S3 | - | _5.15: dataFactoryUtility_<br>Extract-Upload dbo.SendGroup into S3 | _6.15: dataFactoryUtility_<br>Extract-Upload dbo.ABTestSendContent into S3 | - | - | - |
| - | - | _3.16: dataFactoryUtility_<br>Extract-Upload C100010068._PushTag into S3 | - | _5.16: dataFactoryUtility_<br>Extract-Upload dbo.SendJob into S3 | _6.16: dataFactoryUtility_<br>Extract-Upload dbo.ABTestSendType into S3 | - | - | - |
| - | - | _3.17: dataFactoryUtility_<br>Extract-Upload C100010091._GeofenceDefinition into S3 | - | _5.17: dataFactoryUtility_<br>Extract-Upload dbo.SimpleTag into S3 | _6.17: dataFactoryUtility_<br>Extract-Upload dbo.CampaignDefinition into S3 | - | - | - |
| - | - | _3.18: dataFactoryUtility_<br>Extract-Upload C100010091._MobileAddress into S3 | - | _5.18: dataFactoryUtility_<br>Extract-Upload dbo.SimpleTagObject into S3 | _6.18: dataFactoryUtility_<br>Extract-Upload dbo.ImpressionRegion into S3 | - | - | - |
| - | - | _3.19: dataFactoryUtility_<br>Extract-Upload C100010091._MobileMessageTracking into S3 | - | _5.19: dataFactoryUtility_<br>Extract-Upload dbo.SimpleTagObjectType into S3 | _6.19: dataFactoryUtility_<br>Extract-Upload dbo.JobImpressionRegion into S3 | - | - | - |
| - | - | _3.20: dataFactoryUtility_<br>Extract-Upload C100010091._PushAddress into S3 | - | _5.20: dataFactoryUtility_<br>Extract-Upload dbo.SourceAddress into S3 | _6.20: dataFactoryUtility_<br>Extract-Upload dbo.Members_ into S3 | - | - | - |
| - | - | _3.21: dataFactoryUtility_<br>Extract-Upload C100010091._PushMessageAudience into S3 | - | _5.21: dataFactoryUtility_<br>Extract-Upload dbo.tblJobs_Surveys into S3 | _6.21: dataFactoryUtility_<br>Extract-Upload dbo.SendSplit into S3 | - | - | - |
| - | - | _3.22: dataFactoryUtility_<br>Extract-Upload C100010091._PushMessageTracking into S3 | - | _5.22: dataFactoryUtility_<br>Extract-Upload dbo.tblJobSubscriberBatch into S3 | _6.22: dataFactoryUtility_<br>Extract-Upload dbo.Subscriber into S3 | - | - | - |
| - | - | _3.23: dataFactoryUtility_<br>Extract-Upload C100010091._PushSubscriptionHistory into S3 | - | _5.23: dataFactoryUtility_<br>Extract-Upload dbo.tblSurveyAnswers into S3 | _6.23: dataFactoryUtility_<br>Extract-Upload dbo.tblJobs into S3 | - | - | - |
| - | - | _3.24: dataFactoryUtility_<br>Extract-Upload C100010091._PushTag into S3 | - | _5.24: dataFactoryUtility_<br>Extract-Upload dbo.TriggeredSendJob into S3 | _6.24: dataFactoryUtility_<br>Extract-Upload dbo.tblJobs_Lists into S3 | - | - | - |
| - | - | _3.25: dataFactoryUtility_<br>Extract-Upload C100010094._GeofenceDefinition into S3 | - | _5.25: dataFactoryUtility_<br>Extract-Upload InteractionStudio.Definition into S3 | _6.25: dataFactoryUtility_<br>Extract-Upload dbo.tblJobs_URLs into S3 | - | - | - |
| - | - | _3.26: dataFactoryUtility_<br>Extract-Upload C100010094._MobileAddress into S3 | - | - | _6.26: dataFactoryUtility_<br>Extract-Upload dbo.tblSurveyQuestions into S3 | - | - | - |
| - | - | _3.27: dataFactoryUtility_<br>Extract-Upload C100010094._MobileMessageTracking into S3 | - | - | - | - | - | - |
| - | - | _3.28: dataFactoryUtility_<br>Extract-Upload C100010094._PushAddress into S3 | - | - | - | - | - | - |
| - | - | _3.29: dataFactoryUtility_<br>Extract-Upload C100010094._PushMessageAudience into S3 | - | - | - | - | - | - |
| - | - | _3.30: dataFactoryUtility_<br>Extract-Upload C100010094._PushMessageTracking into S3 | - | - | - | - | - | - |
| - | - | _3.31: dataFactoryUtility_<br>Extract-Upload C100010094._PushSubscriptionHistory into S3 | - | - | - | - | - | - |
| - | - | _3.32: dataFactoryUtility_<br>Extract-Upload C100010094._PushTag into S3 | - | - | - | - | - | - |
| - | - | _3.33: dataFactoryUtility_<br>Extract-Upload C100010601._GeofenceDefinition into S3 | - | - | - | - | - | - |
| - | - | _3.34: dataFactoryUtility_<br>Extract-Upload C100010601._MobileAddress into S3 | - | - | - | - | - | - |
| - | - | _3.35: dataFactoryUtility_<br>Extract-Upload C100010601._MobileMessageTracking into S3 | - | - | - | - | - | - |
| - | - | _3.36: dataFactoryUtility_<br>Extract-Upload C100010601._PushAddress into S3 | - | - | - | - | - | - |
| - | - | _3.37: dataFactoryUtility_<br>Extract-Upload C100010601._PushAddressExtension into S3 | - | - | - | - | - | - |
| - | - | _3.38: dataFactoryUtility_<br>Extract-Upload C100010601._PushApplicationCache into S3 | - | - | - | - | - | - |
| - | - | _3.39: dataFactoryUtility_<br>Extract-Upload C100010601._PushDeviceLookup into S3 | - | - | - | - | - | - |
| - | - | _3.40: dataFactoryUtility_<br>Extract-Upload C100010601._PushDeviceStatistics into S3 | - | - | - | - | - | - |
| - | - | _3.41: dataFactoryUtility_<br>Extract-Upload C100010601._PushInAppStatisticsActivityAggregate into S3 | - | - | - | - | - | - |
| - | - | _3.42: dataFactoryUtility_<br>Extract-Upload C100010601._PushMessage into S3 | - | - | - | - | - | - |
| - | - | _3.43: dataFactoryUtility_<br>Extract-Upload C100010601._PushMessageAudience into S3 | - | - | - | - | - | - |
| - | - | _3.44: dataFactoryUtility_<br>Extract-Upload C100010601._PushMessageInApp into S3 | - | - | - | - | - | - |
| - | - | _3.45: dataFactoryUtility_<br>Extract-Upload C100010601._PushMessageTracking into S3 | - | - | - | - | - | - |
| - | - | _3.46: dataFactoryUtility_<br>Extract-Upload C100010601._PushSubscriptionHistory into S3 | - | - | - | - | - | - |
| - | - | _3.47: dataFactoryUtility_<br>Extract-Upload C100010601._PushTag into S3 | - | - | - | - | - | - |
| - | - | _3.48: dataFactoryUtility_<br>Extract-Upload C100011367._GeofenceDefinition into S3 | - | - | - | - | - | - |
| - | - | _3.49: dataFactoryUtility_<br>Extract-Upload C100011367._MobileAddress into S3 | - | - | - | - | - | - |
| - | - | _3.50: dataFactoryUtility_<br>Extract-Upload C100011367._MobileMessageTracking into S3 | - | - | - | - | - | - |
| - | - | _3.51: dataFactoryUtility_<br>Extract-Upload C100011367._PushAddress into S3 | - | - | - | - | - | - |
| - | - | _3.52: dataFactoryUtility_<br>Extract-Upload C100011367._PushMessageAudience into S3 | - | - | - | - | - | - |
| - | - | _3.53: dataFactoryUtility_<br>Extract-Upload C100011367._PushMessageTracking into S3 | - | - | - | - | - | - |
| - | - | _3.54: dataFactoryUtility_<br>Extract-Upload C100011367._PushSubscriptionHistory into S3 | - | - | - | - | - | - |
| - | - | _3.55: dataFactoryUtility_<br>Extract-Upload C100011367._PushTag into S3 | - | - | - | - | - | - |
| - | - | _3.56: dataFactoryUtility_<br>Extract-Upload C515013291._MobileAddress into S3 | - | - | - | - | - | - |
| - | - | _3.57: dataFactoryUtility_<br>Extract-Upload C515013291._MobileMessageTracking into S3 | - | - | - | - | - | - |
| - | - | _3.58: dataFactoryUtility_<br>Extract-Upload dbo.Asset into S3 | - | - | - | - | - | - |
| - | - | _3.59: dataFactoryUtility_<br>Extract-Upload dbo.PushApplicationConfig into S3 | - | - | - | - | - | - |
