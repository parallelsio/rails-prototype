$('#bit_<%= @source_bit.id %>').remove()

<% @bits.each do |bit| %>
$("#map").append "<%= j ( render :template => 'bits/show', :locals => { :bit => @bit = bit}  ) %>"
# # $('#bit_<%= bit.id %>').attr('style', bit_position)
m = showNotification "created image tile bit <%= bit.id %> "
<% end %>

root.initBitBehaviors() # TODO: centralize all JS rebinding behaviors