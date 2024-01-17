## Subscription_Status_Sync_Log

**Description:** Log of Unsubscribes and Resubscribes exported from this SFMC Account.

**Folder:** Data Extensions/Subscription Status Sync/

**Fields in table:** 11

**Sendable:** No

**Testable:** No

| Name | FieldType | MaxLength | IsPrimaryKey | IsNullable | DefaultValue |
| --- | --- | --- | --- | --- | --- |
| SubscriberID | Number |  | - | - |  |
| SubscriberKey | Text | 254 | + | - |  |
| EmailAddress | EmailAddress | 254 | - | - |  |
| DateUnsubscribed | Date |  | - | + |  |
| DateJoined | Date |  | - | + |  |
| Status | Text | 12 | - | + |  |
| SFMC_Account_Name | Text | 20 | - | - |  |
| Parent_BU_MID | Text | 9 | - | - |  |
| Subscription_Status | Text | 20 | - | - |  |
| Log_Timestamp | Date |  | - | - |  |
| DateAdded | Date |  | - | + |  |
