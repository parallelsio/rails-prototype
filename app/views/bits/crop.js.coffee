crop_object = $('#bit_<%= @source_bit.id %>').imgAreaSelect({ instance: true });
crop_object.cancelSelection

$('#bit_<%= @source_bit.id %>').remove()
$("#map").append "<%= j ( render :template => 'bits/show', :locals => { :bit => @bit}  ) %>"
m = showNotification "created image cropped bit <%= @bit.id %> "

root.initBitBehaviors() # TODO: centralize all JS rebinding behaviors