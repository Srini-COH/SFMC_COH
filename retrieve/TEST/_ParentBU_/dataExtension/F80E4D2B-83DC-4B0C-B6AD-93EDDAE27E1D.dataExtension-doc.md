## F80E4D2B-83DC-4B0C-B6AD-93EDDAE27E1D

**Name** (not equal to External Key)**:** CancerCenter_DE

**Description:** Stores Cancer Center subscriber information coming from Cancer Center Website, Preference Center and uploaded using CSV

**Folder:** Shared Items/Shared Data Extensions/

**Fields in table:** 19

**Sendable:** Yes (`Email` to `Subscriber Key`)

**Testable:** No

| Name | FieldType | MaxLength | IsPrimaryKey | IsNullable | DefaultValue |
| --- | --- | --- | --- | --- | --- |
| Email | EmailAddress | 254 | + | - |  |
| Firstname | Text | 50 | - | + |  |
| Status | Text | 50 | - | + | Active |
| Lastname | Text | 50 | - | + |  |
| visitorid | Text | 50 | - | + |  |
| cancerid | Text | 50 | - | + |  |
| CancerOfInterest | Text | 70 | - | + |  |
| cancerrelationship | Text | 50 | - | + |  |
| datechanged | Date |  | - | + |  |
| cancelled | Boolean |  | - | + |  |
| Feedback | Text | 200 | - | + |  |
| Reason_if_Feedback_is_Others | Text | 200 | - | + |  |
| Topics of Interest | Text | 200 | - | + |  |
| Cancers of Interest | Text | 200 | - | + |  |
| Relationship To Cancer | Text | 50 | - | + |  |
| Email Permission Date | Date |  | - | + | GetDate() |
| Permission Source | Text | 50 | - | + |  |
| Membersince | Date |  | - | + | GetDate() |
| SystemUnsubscribeReason | Text | 150 | - | + |  |
