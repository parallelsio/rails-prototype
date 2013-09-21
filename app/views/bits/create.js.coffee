root = global ? window

bit_position = $('#new_bit').attr('style')
$('#new_bit').remove()

$("#map").append "<%= j ( render :template => 'bits/show', :locals => { :bit => @bit }  ) %>"
$('#bit_<%= @bit.id %>').attr('style', bit_position)

m = showNotification "created bit <%= @bit.id %> : <%= @bit.content %>"

root.initBitBehaviors() # TODO: centralize all JS rebinding behaviors