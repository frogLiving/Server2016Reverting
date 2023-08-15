# Server2016Reverting.ps1
 
 ## Purpose
 This is an issue with Server 2016 that has been upgraded and starts reverting off patches.  This fix was proved by MS and be used via SCCM to fix the issue.

 ## Workflow
 * Makes a change to the registery
 * Runs sfc /scannnow
 * Runs dism

**Note:  You really need to reboot.  If you can't do not use the reboot switch.  It is auto set to zero.  If you can.  Set it to 1.
