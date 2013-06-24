console.log "updating <%= @bit.id %> : <%= @bit.content %>"

$("#bit_<%= @bit.id %>").html "<%= j ( render :template => 'bits/show', :locals => { :bit => @bit }  ) %>"