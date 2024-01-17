SELECT DISTINCT
    CF.ContactId,
    CF.EmailAddress,
    CF.CF_First_Name__c,
    CF.CF_Last_Name__c,
    CF.Affiliated_Facility__c,
    CF.ContactType,
    CF.CancerFighterStatus,
    CF.MCStatus,
    CF.CF_MemberCreatedDate,
    CF.CFEmailOptIn,
    CF.MRN,
    CF.EPID,
    CF.FirstTxDate,
    CF.Address_State,
    CF.DMA,
    CF.CEOT_Owner,
    List.CEOT_Owner AS CEOTinList,
    CF.CancerType,
    CF.HasUserAccount,
    CF.Username,
    /*CF.LastLoginDate,*/
    CF.LanguagePreference,
    CF.CFPointBalance,
    CF.CFEngagementScore,
    CF.HopeLevel
FROM
    CEOT_Import_File_for_Targeting AS List
    INNER JOIN CF_ALLMembers_emailable AS CF ON CF.ContactId = List.ContactID
WHERE
    CF.CEOT_Owner IS NOT NULL
    /*Note these rules not needed because they were already applied to the CF_ALLMembers_emailable list:
    AND List.ContactID = CF.ContactId
    AND (Contacts.ctca_iscancerfighter__c IN ('CF','CFCN'))
    AND (Contacts.Email IS NOT NULL)
    AND (Contacts.[Receive_valuable_info_from_CF__c] LIKE '1')
    AND (Contacts.ctca_newstage__c IS NULL or Contacts.ctca_newstage__c NOT LIKE 'Expired')
    AND (Contacts.[HasOptedOutOfEmail] NOT LIKE '1')
    AND (Contacts.[Inactive_Member__c] NOT LIKE '1')
    AND ((AllSubscribers.Status IS NULL) OR (AllSubscribers.Status IN ('Active','Bounced')))
    AND UnEngaged.SubscriberKey IS NULL
    */
