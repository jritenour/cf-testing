#
# Description: This method is used to add a new disk to an existing VM running on VMware
#
# Inputs: $evm.root['vm'], size
#
require 'aws-sdk'

attributes = $evm.root.attributes
vmname=attributes['dialog_get_ec2']
@provider=$evm.vmdb(:ems).find_by_type("ManageIQ::Providers::Amazon::CloudManager")
vm= $evm.vmdb('vm').find_by_name(vmname) || $evm.root['vm']
az=vm.availability_zone.ems_ref
raise "Missing $evm.root['vm'] object" unless vm

# Get the size for the new disk from the root object
size = $evm.root['dialog_size'].to_i
$evm.log("info", "Detected size:<#{size}>")

ec2 = Aws::EC2::Resource.new(
    :access_key_id => @provider.authentication_userid,
    :secret_access_key => @provider.authentication_password,
    :region => @provider.provider_region
  )

# Add disk to a VM
if size.zero?
  $evm.log("error", "Size:<#{size}> invalid")
else
  $evm.log("info", "Creating a new #{size}GB disk in AWS")
volume=ec2.create_volume(:availability_zone => az, :size=>size)
    $evm.log("info", "Waiting for #{volume.id} to become available")
sleep 5
attachment=volume.attach_to_instance(:instance_id => vm.ems_ref, :device => "/dev/sdf")
sleep 1 until attachment.successful? == true
end
