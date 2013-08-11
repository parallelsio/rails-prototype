# TODO: is this correct here? only way I found to have root scope for calling the init function
root = global ? window

console.log 

$("#bit_<%= @bit.id %>").remove()
$("#data .cluster").append "<%= j ( render :template => 'bits/show', :locals => { :bit => @bit }  ) %>"

m = showNotification "updating bit <%= @bit.id %> : <%= @bit.content %>"

root.initBitBehaviors() # TODO: centralize all JS rebinding behaviors