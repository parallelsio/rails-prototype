
root = global ? window


# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->



	# bit : drag and drop
	$(".bit").draggable
	  handle: "p"		# wire drag to handle only
	  stop: (event, ui) ->

	  	request = $.ajax( 
	    	url: '/bits/' + $(this).data('bit-id')
	    	type: 'PUT'
	    	data: {
	    		x: Math.round(ui.position.left)
	    		y: Math.round(ui.position.top)
	    	}
	    )

	    request.done (data) -> 
	    	message = "bit " + data.id + " position saved: T: " + data.location_x + " L:" + data.location_y
	    	type = "warning"
	    	showNotification(message, type)
	    	true

	    request.fail (data) -> $('#notice').text "bit " + data.id + " position save failed "

	    true



	# TOOLBAR : disabled for now, distracting until redesigned	    
	# $(".bit").mouseenter( ->
	# 	m = showNotification "hover in: #{ this.id } ", "warning"

	# 	$(".bit").toolbar
 #    	content: "#toolbar"
 #    	hideOnClick: "true"

 #    $(this).trigger('click')
 #    true

	# 	).mouseleave ->
	# 		# m = showNotification "hover out: #{ this.id } ", "warning"


	$(".bit").mouseenter( ->
		root.hoveredBit = $(this)
		console.log root.hoveredBit

		m = showNotification "hover in: #{ this.id } ", "warning"
		


		return false

		).mouseleave ->
			root.hoveredBit = undefined






	# # flip bit, sounds
	# $(".bit").click ->
	#   add = $(this).find(".content").addClass("flipped")
	  
	#   # display back
	#   $(this).find(".content .back").css "display", "block"
	  
	#   # remove from from flow
	#   $(this).find(".content .front").css "display", "none"

	# 	soundObject = soundManager.createSound(
	# 	  id: "flip_in"
	# 	  url: "/sounds/aim_buddy_logging_in.mp3"
	# 	)
	# 	soundObject.play()


	# 	add.mouseleave ->
	# 	  $(this).removeClass "flipped"
		  
	# 	  # display back
	# 	  $(this).find(".back").css "display", "none"
		  
	# 	  # remove from from flow
	# 	  $(this).find(".front").css "display", ""

	#   soundObject = soundManager.createSound(
	#     id: "flip_out"
	#     url: "/sounds/aim_buddy_logging_out.mp3"
	#   )
	#   soundObject.play()