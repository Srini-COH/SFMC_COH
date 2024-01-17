## CoH_Unsubscribes_Auto_Suppression

**Description:** All Unsubscribes from the CoH SFMC since activation of Subscription Status Sync Automations on 03.13.2023.

**Folder:** _Hidden! Could not find folder with ID 301_/

**Fields in table:** 9

**Sendable:** Yes (`Email Address` to `_EmailAddress`)

**Testable:** No

**Template:** CONTEXTUAL_SUPPRESSION_LISTS

| Name | FieldType | MaxLength | IsPrimaryKey | IsNullable | DefaultValue |
| --- | --- | --- | --- | --- | --- |
| Email Address | EmailAddress | 254 | + | - |  |
| Date Added | Date |  | - | - | GETDATE() |
| SubscriberID | Number |  | - | + |  |
| SubscriberKey | Text | 254 | - | + |  |
| DateJoined | Date |  | - | + |  |
| DateUnsubscribed | Date |  | - | + |  |
| Status | Text | 12 | - | + |  |
| SFMC_Account_Name | Text | 20 | - | + |  |
| Parent_BU_MID | Text | 9 | - | + |  |
