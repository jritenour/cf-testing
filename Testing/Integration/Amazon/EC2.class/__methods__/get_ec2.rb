#
# Test method to pull in a list of all VMware VMs via API
#

begin  
  # Method for logging  
  def log(level, message)  
    @method = 'get_ec2'
    $evm.log(level, "#{@method} - #{message}")  
  end  
  
  # dump_root  
  def dump_root()  
    log(:info, "Root:<$evm.root> Begin $evm.root.attributes")  
    $evm.root.attributes.sort.each { |k, v| log(:info, "Root:<$evm.root> Attribute - #{k}: #{v}")}  
    log(:info, "Root:<$evm.root> End $evm.root.attributes")  
    log(:info, "")  
  end  

prov=$evm.vmdb(:ems).find_by_type("ManageIQ::Providers::Amazon::CloudManager")
names=prov.vms.map {|x| [x["name"],x["name"]]}
  $evm.log(:info, "Inspecting Resource Group  Names: #{names.inspect}")  

    dialog_field = $evm.object  
  
    # set the values  
    dialog_field['values'] = names.to_a
  
    # sort_by: value / description / none  
    dialog_field["sort_by"] = "description"  
    # sort_order: ascending / descending  
    dialog_field["sort_order"] = "ascending"  
    # data_type: string / integer  
    dialog_field["data_type"] = "string"  
    # required: true / false  
    dialog_field["required"] = "true"  
    log(:info, "Dynamic drop down values: #{dialog_field['values']}")  
  
  attributes = $evm.root.attributes
 vm = attributes['dialog_get_vm']  


# Get the size for the new disk from the root object
size = $evm.root['dialog_size'].to_i
$evm.log("info", "Detected size:<#{size}>")

end
