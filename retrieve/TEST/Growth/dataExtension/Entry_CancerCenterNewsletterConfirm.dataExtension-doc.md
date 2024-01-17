## Entry_CancerCenterNewsletterConfirm

**Name** (not equal to External Key)**:** Entry_CancerCenterNewsletterConfirmation

**Description:** Entry Source for the Cancer Center Newsletter Confirmation Journey.

**Folder:** Data Extensions/Cancer Center Newsletter/

**Fields in table:** 3

**Sendable:** Yes (`SubscriberKey` to `Subscriber Key`)

**Testable:** No

**Template:** TriggeredSendDataExtension

| Name | FieldType | MaxLength | IsPrimaryKey | IsNullable | DefaultValue |
| --- | --- | --- | --- | --- | --- |
| SubscriberKey | Text | 254 | - | - |  |
| EmailAddress | EmailAddress | 254 | - | - |  |
| DateAdded | Date |  | - | + | GetDate() |
