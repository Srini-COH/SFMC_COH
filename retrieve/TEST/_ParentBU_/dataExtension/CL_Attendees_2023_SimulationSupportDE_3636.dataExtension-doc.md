## CL_Attendees_2023_SimulationSupportDE_3636

**Description:** Used in Journey - do not use for individual send

**Folder:** Shared Items/Shared Data Extensions/Celebrate Life/CL_2023/

**Fields in table:** 8

**Sendable:** Yes (`ContactID` to `Subscriber Key`)

**Testable:** No

| Name | FieldType | MaxLength | IsPrimaryKey | IsNullable | DefaultValue |
| --- | --- | --- | --- | --- | --- |
| ContactID | Text | 18 | + | - |  |
| EventDate | Text | 50 | - | + |  |
| FirstName | Text | 100 | - | + |  |
| CL_Location | Text | 50 | - | + |  |
| Email | EmailAddress | 254 | - | + |  |
| EventName | Text | 200 | - | + |  |
| Status | Text | 50 | - | + |  |
| RecordInsertDate | Date |  | - | + | GetDate() |
