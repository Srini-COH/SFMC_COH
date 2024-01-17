SELECT DISTINCT  
  Contacts.Id as ContactId,
  Contacts.Email as EmailAddress,
  Contacts.CF_First_Name__c as CF_First_Name__c,
  Contacts.CF_Last_Name__c as CF_Last_Name__c,
  Contacts.Affiliated_Facility__c as CF_Facility,
  Contacts.How_were_you_affected_by_cancer__c AS ContactType,
  Contacts.ctca_iscancerfighter__c as CancerFighterStatus,
  AllSubscribers.Status as MCStatus,
  Contacts.CF_Member_Created_Date__c as CF_MemberCreatedDate,
  Contacts.[Receive_valuable_info_from_CF__c] as CFEmailPermission,

/* BEGIN Identify if MRN is assigned */
  CASE 
  WHEN Contacts.ctca_medicalrecordnumber__c IS NULL THEN 'No'
  WHEN Contacts.ctca_medicalrecordnumber__c IS NOT NULL THEN 'Yes'
  END AS Has_MRN,
/* END Identify if MRN is assigned */  

  Account.ctca_language__pc as LanguagePreference,
  Contacts.CF_Point_Balance__c as CFPointBalance,
  Contacts.CF_Engagement_Score__c as CF_EngagementScore,
  U.Username as Username,
  
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
    LEFT JOIN ENT.Account_Salesforce Account ON Contacts.AccountId = Account.Id
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON (Contacts.Id = AllSubscribers.SubscriberKey and AllSubscribers.ListID = 24)
    LEFT JOIN ENT.Loyalty_Unengaged_Exclusion_Filtered_DE UnEngaged ON Contacts.Id = UnEngaged.SubscriberKey


     
WHERE
    
    (Contacts.ctca_iscancerfighter__c IN ('CF','CFCN'))
    AND (Contacts.CF_Member_Created_Date__c <= DATEADD(day, -3, GETDATE()))
    AND Account.ctca_language__pc = 'Spanish'

    /*AND Contacts.How_were_you_affected_by_cancer__c = 'Patient'
    AND Contacts.ctca_medicalrecordnumber__c IS NOT NULL
    AND Contacts.Affiliated_Facility__c IN ('CTCA, Atlanta','CTCA, Chicago','CTCA, Phoenix')*/
    
    AND Contacts.CF_First_Name__c IS NOT NULL
    
	AND (Contacts.Email IS NOT NULL)
    AND (Contacts.[Receive_valuable_info_from_CF__c] LIKE '1')
    AND (Contacts.[HasOptedOutOfEmail] NOT LIKE '1')
	
	AND (Contacts.ctca_newstage__c IS NULL or Contacts.ctca_newstage__c NOT LIKE 'Expired')
	AND (Account.Expired__c NOT LIKE '1')
    AND (Contacts.HealthCloudGA__DeceasedDate__c IS NULL)
	

	AND (Contacts.[Inactive_Member__c] NOT LIKE '1')
	AND AllSubscribers.Status = 'Active'
	AND UnEngaged.SubscriberKey IS NULL
