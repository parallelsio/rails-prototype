##############################################################
root = global ? window
##############################################################


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
		root.hoveredBitIDNumber = $(this).attr('id').split('_')[1]

		console.log root.hoveredBit
		m = showNotification "hover in: #{ this.id } ", "warning"
		
		event.preventDefault()

		).mouseleave ->
			root.hoveredBit = undefined
			root.hoveredBitIDNumber = undefined
			

	##############################################################







$(document).ready ->

	root.initBitBehaviors()

	##############################################################












