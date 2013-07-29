root = global ? window



# keep track of current mouse position
# used when bit:new/create, use mouse position to create bit at that location
root.x = 0
root.y = 0


# text bits require a form
root.createNewTextBit = ->

  request = $.ajax( 
  	url: '/bits/new'
  	type: 'GET'
  	data: {
	    		position_x: root.x
	    		position_y: root.y
	    	}
  )

  request.done (data) -> 
  	message = "showing new text bit form"
  	type = "warning"
  	$('#map').append($(data))
  
  return this





root.deleteBit = ->

	console.log "inside deleteBit"

	request = $.ajax( 
		url: '/bits/' + root.hoveredBitIDNumber
		type: 'DELETE'
	)

	request.done (data) -> 
		$(root.hoveredBit).remove()

 	
 	return this 
  




root.showMenu = ->
	console.log "show menu"
	console.log "bit #{ root.hoveredBitIDNumber } : x: #{ root.x } y: #{ root.y }"


	# TODO: 
	# get size of the bit
	# calc position for menu
	# animate it out
	# pulsate? wiggle?


	# display temp toolbar
	# $(".bit##{ root.hoveredBit.attr('id')}").menu
	# 	content: "#toolbar"
	# 	hideOnClick: "true"
	
	# $("#{ root.hoveredBit.attr('id')}").
		


root.showNotification = (message, type) ->

	$.pnotify
	  text: message
	  shadow: false
	  animation: 'fade'
	  type: 'info'
	  delay: 1500



# TODO: refactor into function that handles shortcuts
# TODO: figure out key commands to prevent overlap with OS + browser keys
Mousetrap.bind ["n b", "c b"], (e, combo) ->
	m = showNotification "pressed : #{ combo } : new bit at x: #{ root.x } y: #{ root.y }", "warning"
	# console.log "root: x: #{ root.x } y: #{ root.y }"
	newTextBit = createNewTextBit()
	e.preventDefault()



# edit bit on hover
Mousetrap.bind ["command"], (e, combo) ->
	
	if root.hoveredBit
		console.log "got a command hit inside"
		m = showNotification "pressed #{ combo } while hover on bit #{ root.hoveredBitIDNumber } ", "warning"
		
		# only edit if it's a text bit
		if $(root.hoveredBit).hasClass('text')
			showMenu()

			$(root.hoveredBit).find('.front.face').load "/bits/#{  root.hoveredBitIDNumber }/edit"
			$(root.hoveredBit).addClass('editing')

		else
			m = showNotification "not a text bit - can't edit ", "warning"

	else
		console.log "got a command hit outside of bit"

	e.preventDefault()
	

# TODO: too many deletes, too fast leads to 404's
Mousetrap.bind ["d"], (e, combo) ->
	
	if root.hoveredBit
		console.log "delete hit inside bit"
		m = showNotification "pressed #{ combo } while hover on bit #{ root.hoveredBitIDNumber } ", "warning"

		deleteBit()


	else
		console.log "delete hit outside bit"

	e.preventDefault()




# bound to global to allow escape to work inside of the form
# requires extension: mousetrap-global-bind.min
# and _save line at end
Mousetrap.bindGlobal ["escape"], (e, combo) ->

	m = showNotification "pressed : #{ combo } : remove forms ", "warning"
	console.log "pressed escape"

	$('#new_bit').remove()

	# assuming only one at a time
	# TODO: test


	editing_bit_id = $('.editing').attr('id').split('_')[1]
	console.log "editing_bit_id: #{ editing_bit_id }"
	$('.editing').remove()
	$("#data .cluster").append( $('<div>').load("/bits/#{ editing_bit_id }") )

	e.preventDefault()
	_save() 




$(document).ready ->


	# TODO: find a better way of keeping track of X/Y, without binding to mouse
	map = $('body').on "mousemove", (e) -> 

		root.x = e.pageX - this.offsetLeft
		root.y = e.pageY - this.offsetTop

		# console.log " #{root.x} #{root.y}"
		e.preventDefault










	# TODO: resize thumbs, params above arent doing anything
	# TODO: multiple files kinda working, freezes a bit with no indication of what's happening

	map_dropzone = $("div#map").dropzone( { 
		url: "/bits" 
		uploadMultiple: true
		clickable: false
		parallelUploads: 3
		# thumbnailWidth: 250
		# thumbnailHeight: 150
		maxFilesize: 10 # in megs
		previewsContainer: '#image_upload'
		addRemoveLinks: true
		acceptedFiles: "image/*"
		headers: {
			# TODO: technically the Rails UJS driver is supposed to do this
			# rails is complaining about the token, so this quiets it
    		'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    	}


		error: (file, response) ->
			console.log "error: " + response

		success: (file, response, event) ->
			console.log "success: " + file.name
			this.removeFile(file)

			#TODO: get header location, get bit id, and show new bit
			# $("#data .cluster").append( $('<div>').load("/bits/#{ Header['location'] }") )

		sending: (file, xhr, formData) ->
			console.log "sending: attaching formData ... "
			formData.append "position_x", root.x
			formData.append "position_y", root.y

		# drop: (file) ->
			# console.log "drop: processing ... "

	})










