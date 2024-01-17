## D7DDAECB-B9BF-49D4-939B-6C1DCF31174B

**Name** (not equal to External Key)**:** CF_Pt_MeetTheTeam_DE

**Description:** Used in the Meet the CF team Journey, members ADDED by automation

**Folder:** Shared Items/Shared Data Extensions/Cancer Fighters/CF Journey DEs/

**Fields in table:** 11

**Sendable:** Yes (`ContactID` to `Subscriber Key`)

**Testable:** Yes

| Name | FieldType | MaxLength | IsPrimaryKey | IsNullable | DefaultValue |
| --- | --- | --- | --- | --- | --- |
| ContactID | Text | 50 | + | - |  |
| CF_First_Name__c | Text | 100 | - | + |  |
| CF_Last_Name__c | Text | 100 | - | + |  |
| CF_Facility | Text | 2500 | - | + |  |
| ContactType | Text | 50 | - | + |  |
| CancerFighterStatus | Text | 10 | - | + |  |
| MCStatus | Text | 50 | - | + |  |
| EmailAddress | EmailAddress | 254 | - | + |  |
| CFEmailPermission | Boolean |  | - | + |  |
| DateInserted | Date |  | - | + | GetDate() |
| CF_Member_Created_Date | Text | 200 | - | + |  |
