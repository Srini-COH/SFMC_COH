## ABDA2F2B-F07C-4B5D-B7B6-8FFC40489ED3

**Name** (not equal to External Key)**:** RMT_2022-09_BehavioralHealth

**Description:** n/a

**Folder:** Data Extensions/RiskManagementTool/RMT_Occasion_Emails/2022_RMT_Occasion_Emails/

**Fields in table:** 15

**Sendable:** Yes (`SubscriberKey` to `Subscriber Key`)

**Testable:** Yes

| Name | FieldType | MaxLength | IsPrimaryKey | IsNullable | DefaultValue |
| --- | --- | --- | --- | --- | --- |
| SubscriberKey | Text | 50 | + | - |  |
| Email | EmailAddress | 254 | - | + |  |
| RMT_Completed | Boolean |  | - | + |  |
| FirstName | Text | 50 | - | + | Friend |
| Last_RMT_Start_Date | Date |  | - | + |  |
| Converted | Boolean |  | - | + |  |
| LeadRecordType | Text | 50 | - | + |  |
| RMTOptInStatus | Text | 50 | - | + |  |
| RMTCancerStatus | Text | 50 | - | + |  |
| Last_RMT_Completed_Date | Date |  | - | + |  |
| CancerStatus | Text | 50 | - | + |  |
| SubscriptionStatus | Text | 50 | - | + |  |
| RecordInsertDate | Date |  | - | + | GetDate() |
| DMA | Text | 255 | - | + |  |
| Gender | Text | 20 | - | + |  |
