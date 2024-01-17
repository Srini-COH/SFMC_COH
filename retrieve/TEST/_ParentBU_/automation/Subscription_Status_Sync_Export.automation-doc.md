## Subscription_Status_Sync_Export

**Name** (not equal to External Key)**:** Subscription Status Sync Export

**Description:** Query changes to AllSubscribers subscription status (Unsubscribe, Resubscribe) for anytime yesterday. Export the results as CSV to an FTP location.

**Folder:** my automations/Subscription Status Sync/

**Started by:** Schedule

**Status:** Scheduled

**Schedule:**

* Start: 2023-03-14 02:30:00 -06:00
* End: 2079-06-06 00:00:00 -06:00
* Timezone: Central Standard Time
* Recurrance: every day until end date

**Notifications:** _none_


| Step 1<br>_<small>Query changes to subscription status yesterday (Unsubscribe, Resubscribe).</small>_ | Step 2<br>_<small>Export the Unusbscribe DE and Resubscribe DE records to the Safehouse.</small>_ | Step 3<br>_<small>Moves the Unsubscribe CSV and Resubscribe CSV from the Safehouse to an FTP File Location.</small>_ | Step 4<br>_<small>Log Unsubscribes.</small>_ | Step 5<br>_<small>Log Resubscribes.</small>_ |
| --- | --- | --- | --- | --- |
| _1.1: query_<br>Unsubscribe_Yesterday_SQL | _2.1: dataExtract_<br>Unsubscribe_Yesterday_DE_Export | _3.1: fileTransfer_<br>Unsubscribe_Yesterday_Move_FTP | _4.1: query_<br>Unsubscribe_Yesterday_Log | _5.1: query_<br>Resubscribe_Yesterday_Log |
| _1.2: query_<br>Resubscribe_Yesterday_SQL | _2.2: dataExtract_<br>Resubscribe_Yesterday_DE_Export | _3.2: fileTransfer_<br>Resubscribe_Yesterday_Move_FTP | - | - |
