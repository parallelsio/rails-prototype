# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->




	# submit ajax post to save position on drag and drop
	# wire drag to handle only


	# TODO: concat the ID into the url

	$(".bit").draggable
	  handle: "p"
	  # axis: 'y'
	  stop: (event, ui) ->
	  	alert("Bit position saved: T: " + Math.round(ui.position.top) + " L: " + Math.round(ui.position.left))
	  	request = $.ajax 
	    	url: '/bits/4'
	    	type: 'PUT'
	    	data: {
	    		x: ui.position.top
	    		y: ui.position.left
	    	}

	    request.done(data) -> console.log(data)	
	    #.done(data) -> $('#my-menus').append "Bit position saved: T: " + ui.position.top + "L:" + ui.position.left + "!"

	    request.fail -> $('my-menus').show()



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