## 738DFDD6-D2E6-41CB-AEAF-DA5F66BF0F79

**Name** (not equal to External Key)**:** Chicago_CelebrateLifeInvitees_2020

**Description:** DE used to identify who is invited to the Atlanta Celebrate Life

**Folder:** Shared Items/Shared Salesforce Data Extensions/Celebrate Life/CL 2020/

**Fields in table:** 14

**Sendable:** Yes (`ContactId` to `Subscriber Key`)

**Testable:** Yes

| Name | FieldType | MaxLength | IsPrimaryKey | IsNullable | DefaultValue |
| --- | --- | --- | --- | --- | --- |
| ContactId | Text | 50 | + | - |  |
| FirstName | Text | 100 | - | + |  |
| LastName | Text | 50 | - | + |  |
| Email | EmailAddress | 254 | - | + |  |
| CancerType | Text | 50 | - | + |  |
| Facility | Text | 50 | - | + |  |
| CFStatus | Text | 50 | - | + |  |
| CFReceiveInfoPermission | Boolean |  | - | + |  |
| ContactStatus | Text | 50 | - | + |  |
| HasOptedOutOfEmail | Boolean |  | - | + |  |
| MCStatus | Text | 50 | - | + |  |
| RecordInsertDate | Date |  | - | + | GETDATE() |
| MRN | Text | 20 | - | - |  |
| PacketType | Text | 50 | - | + |  |
