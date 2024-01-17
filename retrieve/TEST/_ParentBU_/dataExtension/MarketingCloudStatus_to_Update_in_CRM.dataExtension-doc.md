## MarketingCloudStatus_to_Update_in_CRM

**Description:** n/a

**Folder:** Data Extensions/Data Maintenance/

**Fields in table:** 8

**Sendable:** Yes (`SubscriberKey` to `Subscriber Key`)

**Testable:** Yes

| Name | FieldType | MaxLength | IsPrimaryKey | IsNullable | DefaultValue |
| --- | --- | --- | --- | --- | --- |
| SubscriberKey | Text | 254 | + | - |  |
| Status | Text | 12 | - | - |  |
| EmailAddress | EmailAddress | 254 | - | - |  |
| RecordInsertDate | Date |  | - | + | GetDate() |
| DateUndeliverable | Date |  | - | + |  |
| DateJoined | Date |  | - | + |  |
| DateUnsubscribed | Date |  | - | + |  |
| CRM_MCStatus | Text | 50 | - | + |  |
