bit_position = $('#new_bit').attr('style')
$('#new_bit').remove()

$("#data .cluster").append "<%= j ( render :template => 'bits/show', :locals => { :bit => @bit }  ) %>"
$('#bit_<%= @bit.id %>').attr('style', bit_position)

m = showNotification "updating bit <%= @bit.id %> : <%= @bit.content %>", "warning"
root.initBitBehaviors() # TODO: centralize all JS rebinding behaviors