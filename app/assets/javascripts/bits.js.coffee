##############################################################
root = global ? window
##############################################################

root.initBitBehaviors = ->


	##############################################################
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
	    	showNotification("bit #{ data.id } position saved: x: #{ data.position_x } y: #{ data.position_y }")
	    	true

	    request.fail (data) -> $('#notice').text "bit #{ data.id } position save failed ", "error"

	    true

	#############################################################

	# BIT : HOVER
	# used to set context of which bit is moused over
	# we'll use this to bind the show menu key command
	# TODO: refactor: global variable for hovered state is probably not a good way
	$(".bit").mouseenter( (event) ->
		root.hoveredBit = $(this)
		root.hoveredBitIDNumber = $(this).attr('id').split('_')[1]
		m = showNotification "hover in: #{ this.id } "
		event.preventDefault()

		).mouseleave ->
			m = showNotification "hover out: #{ this.id } "
			root.hoveredBit = undefined
			root.hoveredBitIDNumber = undefined


	#############################################################

	# zoom will require an a tag element
	# since zoom functionality is only enabled by clicking a button while
	# hovering, disable default a tag functionality, so
	# if user clicks an image bit, it won't mess up the app
	$(".bit .front.face .content .zoom a").click (e) ->
	  e.preventDefault()			

	##############################################################


$(document).ready ->

	root.initBitBehaviors()
	


	##############################################################












