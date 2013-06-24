# TODO: is this correct here? only way I found to access init function here
root = global ? window

console.log 

$("#bit_<%= @bit.id %>").remove()
$("#data .cluster").append "<%= j ( render :template => 'bits/show', :locals => { :bit => @bit }  ) %>"

m = showNotification "updating bit <%= @bit.id %> : <%= @bit.content %>", "warning"

root.initBitBehaviors() # TODO: after reload, need to rebind all JS behaviors