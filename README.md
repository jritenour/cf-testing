# cf-testing

This is set of WIP Red Hat CloudForms/ManageIQ automatio methods to add disks to VMware VMs & AWS intances via custom buttons or service catalog items.


To use: 

1. Clone this repo.
2. Import the add_disk_catalog.zip as a new automation domain (Automate -> Import/Export -> browse & upload file)
3. Import the cf_add_disk_dialogs.yml file (Automate -> Customization -> Import/Export -> Service Dialog Import/Export -> browse & upload file)
4. Create new buttons:
   * "vSphere Add Disk" which makes a "disk_add" request and uses the vsphere-vm-disk-add dialog
   * "EC2 Add Disk" which makes a "aws_disk_add" request and also uses the vpshere-vm-disk-add dialog (really, it's just collecting a size - may spint his off into a new dialog & add an AWS mount point later
6. Create service catalog items:
   * "Add disk to VMware VM", custom type, which uses the "Get VMs" dialog and uses "Service/Provisioning/StateMachines/ServiceProvisoin_Template/add_disk" as the provisioning entry point
   * "Add disk to EC2", custom type, which uses the "Get Instances" dialog, and uses "Service/Provisioning/StateMachines/ServiceProvisoin_Template/ec2_add_disk" as the provisioning entry point
7. You can now test adding disks on VMware VMs & EC2 instances using custom buttons from the VM/intance object, or service catalog item.  Note that when calling the catalog items, they will pull the list of all VMs from the specified provider into a drop down list to facilitate selection of the VM to add a disk to.  In larger environments, this may take a while to return the entire list of VMs.

NOTE: As of this point, only adding disks is supported.  Removing/deleting disk support may be added later, but that particular workflow requires a bit more planning.  
