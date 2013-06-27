
root = global ? window


# TODO: set up a way to pass a bit a parameter
# versus updating all, for performance when needed
# ie, updating a bit via AJAX
root.initBitBehaviors = ->


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	



	# BIT : DRAG + DROP
	$(".bit").draggable
	  handle: "p"		# wire drag to handle only
	  stop: (event, ui) ->

	  	# TODO : dont send drag of a form to save
	  	request = $.ajax( 
	    	url: '/bits/' + $(this).data('bit-id')
	    	type: 'PUT'
	    	data: {
	    		position_x: Math.round(ui.position.left)
	    		position_y: Math.round(ui.position.top)
	    		content: $(this).find('.face.front .content').text().trim()
	    	}
	    )

	    request.done (data) -> 
	    	message = "bit #{ data.id } position saved: x: #{ data.position_x } y: #{ data.position_y }"
	    	type = "warning"
	    	showNotification(message, type)
	    	true

	    request.fail (data) -> $('#notice').text "bit #{ data.id } position save failed "

	    true

	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



	# BIT : HOVER
	# used to set context of which bit is moused over
	# we'll use this to bind the show menu key command
	# TODO: refactor: global variable for hovered state is probably not a good way
	$(".bit").mouseenter( (event) ->
		root.hoveredBit = $(this)
		console.log root.hoveredBit

		m = showNotification "hover in: #{ this.id } ", "warning"
		
		event.preventDefault()

		).mouseleave ->
			root.hoveredBit = undefined
			

	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	






	##############################################################
	##############################################################

$(document).ready ->


	root.initBitBehaviors()





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






	# # flip bit
	# $(".bit").on "click", ->

	#   add = $(this).find(".container").addClass("flipped")
	  
	#   # display back
	#   $(this).find(".container .back").css "display", "block"
	  
	#   # remove from flow
	#   $(this).find(".container .front").css "display", "none"

	# 	# soundObject = soundManager.createSound(
	# 	#   id: "flip_in"
	# 	#   url: "/sounds/aim_buddy_logging_in.mp3"
	# 	# )
	# 	# soundObject.play()


	# 	add.on "mouseleave", ->
	# 	  $(this).removeClass "flipped"
		  
	# 	  # display back
	# 	  $(this).find(".back").css "display", "none"
		  
	# 	  # remove from from flow
	# 	  $(this).find(".front").css "display", ""

	#   # soundObject = soundManager.createSound(
	#   #   id: "flip_out"
	#   #   url: "/sounds/aim_buddy_logging_out.mp3"
	#   # )
	#   # soundObject.play()
















