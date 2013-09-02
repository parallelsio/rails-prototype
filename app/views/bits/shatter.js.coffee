$('#bit_<%= @source_bit.id %>').remove()

<% @bits.each do |bit| %>
$("#map").append "<%= j ( render :template => 'bits/show', :locals => { :bit => @bit = bit}  ) %>"
m = showNotification "created image tile bit <%= bit.id %> "
<% end %>

root.initBitBehaviors() # TODO: centralize all JS rebinding behaviors