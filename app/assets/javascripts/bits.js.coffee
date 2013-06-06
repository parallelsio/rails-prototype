# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->


	showNotification = (data) ->
	  n = noty(
	    text: "bit " + data.id + " position saved: T: " + data.location_x + " L:" + data.location_y
	    type: "warning"
	    layout: "topRight"
	    closeWith: ["hover"]
	    animation:
	      open:
	        height: "toggle"

	      close:
	        height: "toggle"

	      easing: "swing"
	      speed: 100 # opening & closing animation speed
	  )


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
	    	showNotification(data)
	    	$('#header .message').text "bit " + data.id + ": position saved: T: " + data.location_x + " L:" + data.location_y + "!"
	    	true

	    request.fail (data) -> $('#notice').text "bit " + data.id + " position save failed "

	    true








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