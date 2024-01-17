## OrphanedContactsWithoutSubscribers

**Description:** Delete-able All Contact records. SF ContactID as subscriber key but not synched and never sent to (no All Sub record)

**Folder:** Data Extensions/ContactDelete/

**Fields in table:** 2

**Sendable:** Yes (`ContactKey` to `Subscriber Key`)

**Testable:** No

| Name | FieldType | MaxLength | IsPrimaryKey | IsNullable | DefaultValue |
| --- | --- | --- | --- | --- | --- |
| ContactKey | Text | 255 | - | - |  |
| SubscriberKey | Text | 255 | - | + |  |
