## Resubscribe_Yesterday_Import

**Description:** Import target for Resubscribe_Yesterday CSV on FTP. This includes all resubscriptions from anytime yesterday in the other SFMC Account.

**Folder:** Data Extensions/Subscription Status Sync/

**Fields in table:** 9

**Sendable:** No

**Testable:** No

| Name | FieldType | MaxLength | IsPrimaryKey | IsNullable | DefaultValue |
| --- | --- | --- | --- | --- | --- |
| SubscriberID | Number |  | - | + |  |
| SubscriberKey | Text | 254 | - | + |  |
| Email | EmailAddress | 254 | - | + |  |
| DateUnsubscribed | Date |  | - | + |  |
| DateJoined | Date |  | - | + |  |
| Status | Text | 12 | - | + |  |
| SFMC_Account_Name | Text | 20 | - | + |  |
| Parent_BU_MID | Text | 9 | - | + |  |
| DateAdded | Date |  | - | - |  |
