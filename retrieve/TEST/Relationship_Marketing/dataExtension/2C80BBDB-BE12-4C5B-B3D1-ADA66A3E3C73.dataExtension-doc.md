## 2C80BBDB-BE12-4C5B-B3D1-ADA66A3E3C73

**Name** (not equal to External Key)**:** Test_Oppty_Caregivers_Fulfillment_DE

**Description:** use for proofing the Opportunity Caregiver Fulfillment emails

**Folder:** Data Extensions/TriggeredSendPreviews/

**Fields in table:** 4

**Sendable:** Yes (`SubscriberKey` to `Subscriber Key`)

**Testable:** No

**Template:** TriggeredSendDataExtension

| Name | FieldType | MaxLength | IsPrimaryKey | IsNullable | DefaultValue |
| --- | --- | --- | --- | --- | --- |
| SubscriberKey | Text | 254 | - | - |  |
| EmailAddress | EmailAddress | 254 | - | - |  |
| RecordID | Text | 18 | - | - |  |
| RecordInsertDate | Date |  | - | + | GetDate() |
