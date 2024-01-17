## Subscription_Status_Sync_Import

**Name** (not equal to External Key)**:** Subscription Status Sync Import

**Description:** Import Unsubscribe CSV from FTP location and update AutoSuppression list. Import Resubscribe CSV from FTP location and update AutoSuppression list.

**Folder:** my automations/Subscription Status Sync/

**Started by:** Schedule

**Status:** Scheduled

**Schedule:**

* Start: 2023-03-14 03:30:00 -06:00
* End: 2079-06-06 00:00:00 -06:00
* Timezone: Central Standard Time
* Recurrance: every day until end date

**Notifications:**

* Error: maggie.redmon@ctca-hope.com

| Step 1<br>_<small>Import Unsubscribes directly to the Auto Suppression. Import Resubscribes to a DE. </small>_ | Step 2<br>_<small>Remove Resubscribes from the Auto Suppression via SSJS.</small>_ |
| --- | --- |
| _1.1: importFile_<br>Unsubscribe_Yesterday_Import | _2.1: script_<br>Resubscribe_Yesterday_Remove |
| _1.2: importFile_<br>Resubscribe_Yesterday_Import | - |
