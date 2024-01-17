SELECT DISTINCT  
  Contacts.Id as ContactId,
  Contacts.Email as EmailAddress,
  Contacts.CF_First_Name__c as CF_First_Name__c,
  Contacts.CF_Last_Name__c as CF_Last_Name__c,
  Contacts.Affiliated_Facility__c as Affiliated_Facility__c,
  Contacts.How_were_you_affected_by_cancer__c AS ContactType,
  Contacts.ctca_iscancerfighter__c as CancerFighterStatus,
  AllSubscribers.Status as MCStatus,
  Contacts.CF_Member_Created_Date__c as CF_MemberCreatedDate,
  Contacts.[Receive_valuable_info_from_CF__c] as CFEmailOptIn,
  Contacts.ctca_medicalrecordnumber__c as MRN,
  Contacts.prm_epid__c as EPID,
  Contacts.First_Treatment_Date__c as FirstTxDate,
  Contacts.MailingState as Address_State,
  Contacts.DMA__c as DMA,
  CEOT.Name as CEOT_Owner,
  Contacts.Cancer_Type__c as CancerType,
  PersonAccount.Celebrant_Eligible__c as CelebrantEligible,
    CASE 
  WHEN PersonAccount.Celebrant_Eligible__c = 1 THEN PersonAccount.Celebrant_Year__pc 
    END AS CelebrantYear,
  
  Contacts.Has_User_Account__c as HasUserAccount,
  U.Username as Username,
  U.Hope_Program_eligible__c as HopeProgramEligible,
  U.CommunityNickname as CommunityNickname,
  /*PersonAccount.Last_Login_Date__c as LastLoginDate,*/
  PersonAccount.ctca_language__pc as LanguagePreference,
  Contacts.CF_Point_Balance__c as CFPointBalance,
  Contacts.CF_Engagement_Score__c as CFEngagementScore,

 /* BEGIN Dynamically Populate Hope Program Level */
  CASE 
  WHEN Contacts.CF_Engagement_Score__c BETWEEN 5 and 49 THEN 'Bronze'
  WHEN Contacts.CF_Engagement_Score__c BETWEEN 50 and 249 THEN 'Silver'
  WHEN Contacts.CF_Engagement_Score__c BETWEEN 250 and 499 THEN 'Gold'
  WHEN Contacts.CF_Engagement_Score__c >= 500 THEN 'Platinum'
  END AS HopeLevel
  /* END Dynamically Populate Hope Program Level */
 



FROM
  ENT.Contact_Salesforce AS Contacts
    LEFT JOIN ENT.User_Salesforce U ON U.ContactId = Contacts.Id
    LEFT JOIN ENT.Account_Salesforce PersonAccount ON Contacts.AccountId = PersonAccount.Id
        LEFT JOIN ENT.User_Salesforce CEOT ON CEOT.Id = PersonAccount.CEOT_Owner__c
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON (Contacts.Id = AllSubscribers.SubscriberKey and AllSubscribers.ListID = 24)
    LEFT JOIN ENT.Loyalty_Unengaged_Exclusion_Filtered_DE UnEngaged ON Contacts.Id = UnEngaged.SubscriberKey


     
WHERE
    (Contacts.ctca_iscancerfighter__c IN ('CF','CFCN'))
	AND (Contacts.Email IS NOT NULL)
    AND (Contacts.[Receive_valuable_info_from_CF__c] LIKE '1')
	AND (Contacts.ctca_newstage__c IS NULL or Contacts.ctca_newstage__c NOT LIKE 'Expired')
	AND (PersonAccount.Expired__c NOT LIKE '1')
    AND (Contacts.HealthCloudGA__DeceasedDate__c IS NULL)
	AND (Contacts.[HasOptedOutOfEmail] NOT LIKE '1')
	AND (Contacts.[Inactive_Member__c] NOT LIKE '1')
	AND ((AllSubscribers.Status IS NULL) OR (AllSubscribers.Status IN ('Active','Bounced')))
	AND UnEngaged.SubscriberKey IS NULL
