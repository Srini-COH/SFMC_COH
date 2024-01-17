## 3E7CB0CA-B52B-4B98-85CF-FA5BF8DF8E4D

**Name** (not equal to External Key)**:** CME_Invite_Test_DE

**Description:** SF Contacts to invite to the CTCA Forum in Tulsa

**Folder:** Shared Items/Shared Salesforce Data Extensions/Physician Salesforce Communications/

**Fields in table:** 9

**Sendable:** Yes (`ContactId` to `Subscriber Key`)

**Testable:** Yes

| Name | FieldType | MaxLength | IsPrimaryKey | IsNullable | DefaultValue |
| --- | --- | --- | --- | --- | --- |
| ContactId | Text | 50 | + | - |  |
| FirstName | Text | 50 | - | - |  |
| LastName | Text | 50 | - | - |  |
| Email | EmailAddress | 254 | - | - |  |
| Account | Text | 100 | - | + |  |
| ContactStatus | Text | 50 | - | + |  |
| HasOptedOutOfEmail | Text | 50 | - | + |  |
| MCStatus | Text | 50 | - | + |  |
| RecordInsertDate | Date |  | - | - | GetDate() |
