## OrphanedEmailAddressAsSubscriberKeyFromAllContacts

**Description:** Delete-able All Contact records. Email as subscriber key but never sent to (no All Sub record)

**Folder:** Data Extensions/ContactDelete/

**Fields in table:** 3

**Sendable:** No

**Testable:** No

| Name | FieldType | MaxLength | IsPrimaryKey | IsNullable | DefaultValue |
| --- | --- | --- | --- | --- | --- |
| ContactKey | Text | 255 | - | - |  |
| SubscriberKey | Text | 255 | - | + |  |
| RecordInsertDate | Date |  | - | + | GetDate() |
