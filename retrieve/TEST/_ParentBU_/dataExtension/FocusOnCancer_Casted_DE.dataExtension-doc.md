## FocusOnCancer_Casted_DE

**Description:** n/a

**Folder:** Shared Items/Shared Data Extensions/

**Fields in table:** 3

**Sendable:** Yes (`Email` to `Subscriber Key`)

**Testable:** Yes

| Name | FieldType | MaxLength | IsPrimaryKey | IsNullable | DefaultValue |
| --- | --- | --- | --- | --- | --- |
| Email | EmailAddress | 254 | - | - |  |
| Optin_Date | Date |  | - | + | GetDate() |
| Permission_Source | Text | 50 | - | + | Casted |
