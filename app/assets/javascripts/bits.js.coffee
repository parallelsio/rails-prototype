# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->




	# submit ajax post to save position on drag and drop
	# wire drag to handle only


	# TODO: concat the ID into the url

	$(".bit").draggable
	  handle: "p"
	  stop: (event, ui) ->
	  	#alert("Bit position saved: T: " + ui.position.top + "L:" + ui.position.left + "!")

	  	request = $.ajax( 
	    	url: '/bits/' + $(this).data('bit-id') + '/position'
	    	type: 'PUT'
	    	data: {
	    		x: Math.round(ui.position.top)
	    		y: Math.round(ui.position.left)
	    	}
	    )

	    request.done (data) -> 
	    	console.log("Bit position saved: T: " + data.x + " L: ")
	    	$('#notice').text "bit position saved: T: " + data.x + "L:" + data.y + "!"
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