## C2D220CA-9403-4CFD-BE9B-29D0F03DFBAA

**Name** (not equal to External Key)**:** DV_Job

**Description:** Stores information about your Email Sends Jobs

**Folder:** Data Extensions/Data Views/

**Fields in table:** 37

**Sendable:** No

**Testable:** No

| Name | FieldType | MaxLength | IsPrimaryKey | IsNullable | DefaultValue |
| --- | --- | --- | --- | --- | --- |
| JobID | Number |  | - | - |  |
| EmailID | Number |  | - | + |  |
| AccountID | Number |  | - | + |  |
| AccountUserID | Number |  | - | + |  |
| FromName | Text | 130 | - | + |  |
| FromEmail | EmailAddress | 254 | - | + |  |
| SchedTime | Date |  | - | + |  |
| PickupTime | Date |  | - | + |  |
| DeliveredTime | Date |  | - | + |  |
| EventID | Text | 50 | - | + |  |
| IsMultipart | Boolean |  | - | - |  |
| JobType | Text | 50 | - | + |  |
| JobStatus | Text | 50 | - | + |  |
| ModifiedBy | Number |  | - | + |  |
| ModifiedDate | Date |  | - | + |  |
| EmailName | Text | 100 | - | + |  |
| EmailSubject | Text | 200 | - | + |  |
| IsWrapped | Boolean |  | - | - |  |
| TestEmailAddr | EmailAddress | 254 | - | + |  |
| Category | Text | 100 | - | - |  |
| BccEmail | EmailAddress | 254 | - | + |  |
| OriginalSchedTime | Date |  | - | + |  |
| CreatedDate | Date |  | - | - |  |
| CharacterSet | Text | 30 | - | + |  |
| IPAddress | Text | 50 | - | + |  |
| SalesForceTotalSubscriberCount | Number |  | - | - |  |
| SalesForceErrorSubscriberCount | Number |  | - | - |  |
| SendType | Text | 128 | - | - |  |
| DynamicEmailSubject | Text | 1000 | - | + |  |
| SuppressTracking | Boolean |  | - | - |  |
| SendClassificationType | Text | 32 | - | + |  |
| SendClassification | Text | 36 | - | + |  |
| ResolveLinksWithCurrentData | Boolean |  | - | - |  |
| EmailSendDefinition | Text | 36 | - | + |  |
| DeduplicateByEmail | Boolean |  | - | - |  |
| TriggererSendDefinitionObjectID | Text | 36 | - | + |  |
| TriggeredSendCustomerKey | Text | 36 | - | + |  |
