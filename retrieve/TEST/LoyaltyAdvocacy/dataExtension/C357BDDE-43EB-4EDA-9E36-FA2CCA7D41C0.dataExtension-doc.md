## C357BDDE-43EB-4EDA-9E36-FA2CCA7D41C0

**Name** (not equal to External Key)**:** CF_Send_CEOT_Intro

**Description:** Emailable CFs identified by a list imported

**Folder:** Salesforce Data Extensions/Cancer Fighters/

**Fields in table:** 25

**Sendable:** Yes (`ContactID` to `Subscriber Key`)

**Testable:** Yes

| Name | FieldType | MaxLength | IsPrimaryKey | IsNullable | DefaultValue |
| --- | --- | --- | --- | --- | --- |
| ContactID | Text | 50 | + | - |  |
| CF_First_Name__c | Text | 255 | - | + | Cancer Fighter |
| CF_Last_Name__c | Text | 255 | - | + |  |
| Affiliated_Facility__c | Text | 2500 | - | + |  |
| ContactType | Text | 4000 | - | + |  |
| CancerFighterStatus | Text | 10 | - | + |  |
| MCStatus | Text | 50 | - | + |  |
| EmailAddress | EmailAddress | 254 | - | + |  |
| CFEmailOptIn | Boolean |  | - | + |  |
| CF_MemberCreatedDate | Date |  | - | + |  |
| MRN | Text | 50 | - | + |  |
| EPID | Text | 255 | - | + |  |
| Address_State | Text | 255 | - | + |  |
| DMA | Text | 1300 | - | + |  |
| CancerType | Text | 4000 | - | + |  |
| HasUserAccount | Boolean |  | - | + |  |
| RecordInsertDate | Date |  | - | + | GetDate() |
| CFPointBalance | Decimal | 38,0 | - | + |  |
| CFEngagementScore | Decimal | 38,0 | - | + |  |
| HopeLevel | Text | 50 | - | + |  |
| Username | Text | 100 | - | + |  |
| LanguagePreference | Text | 100 | - | + |  |
| FirstTxDate | Date |  | - | + |  |
| CEOT_Owner | Text | 150 | - | + |  |
| CEOTinList | Text | 100 | - | + |  |
