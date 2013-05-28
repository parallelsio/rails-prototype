# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->



	# wire drag and drop to each bit's handle, which only shows on hover
	$(".bit").draggable
	  handle: "p"
	  stop: (event, ui) ->
	    # alert ui.position.top






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