## 2DCA640D-4C46-4E0E-AD8D-D9FA2FDBB988

**Name** (not equal to External Key)**:** RMT_Results_Email_Contact - 2020-03-09T085149905

**Description:** n/a

**Folder:** Data Extensions/

**Fields in table:** 4

**Sendable:** Yes (`Account:PersonContact:Id` to `Subscriber Key`)

**Testable:** No

| Name | FieldType | MaxLength | IsPrimaryKey | IsNullable | DefaultValue |
| --- | --- | --- | --- | --- | --- |
| Account:Id | Text | 18 | - | - |  |
| Account:PersonContact:Id | Text | 18 | - | - |  |
| Account:PersonContact:Email | EmailAddress | 80 | - | + |  |
| Account:PersonContact:HasOptedOutOfEmail | Boolean |  | - | + | False |
