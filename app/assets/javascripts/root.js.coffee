##########################################################################################
root = global ? window
##########################################################################################

# keep track of current mouse position
# used when bit:new/create, use mouse position to create bit at that location
root.x = 0
root.y = 0

##########################################################################################

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
  	m = showNotification "showing new text bit form"
  	$('#map').append($(data))
  	$('#new_bit textarea').focus()
  
  return this



##########################################################################################
root.deleteBit = ->

	console.log "inside deleteBit"

	request = $.ajax( 
		url: '/bits/' + root.hoveredBitIDNumber
		type: 'DELETE'
	)

	request.done (data) -> 
		$(root.hoveredBit).remove()
		m = showNotification "deleted bit_#{ root.hoveredBitIDNumber }"

 	return true 
  

##########################################################################################
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
		

##########################################################################################
root.showNotification = (message, type) ->

	# default to info. other options: success, error, notice
	type = "info" if typeof (type) is "undefined"

	$.pnotify
	  text: message
	  shadow: false
	  animation: 'fade'
	  type: type
	  delay: 1500

	console.log message


##########################################################################################

# TODO: refactor into function that handles shortcuts
# TODO: figure out key commands to prevent overlap with OS + browser keys
Mousetrap.bind ["n b", "c b"], (e, combo) ->
	m = showNotification "pressed : #{ combo } : new bit at x: #{ root.x } y: #{ root.y }"
	# console.log "root: x: #{ root.x } y: #{ root.y }"
	newTextBit = createNewTextBit()
	e.preventDefault()


##########################################################################################

# Command key triggers editing of a text, and enables zoom for an image bit 
# acts as a momentary push button for image, meaning only works while holding command
# thus, requires two bindings, on key down + key up


Mousetrap.bind "command", ( (e,combo) ->

	if root.hoveredBit
		m = showNotification "#{ combo } down while hover on bit #{ root.hoveredBitIDNumber } "
		
		# only edit if it's a text bit
		if $(root.hoveredBit).hasClass('text')
			# showMenu()

			$(root.hoveredBit).find('.front.face').load "/bits/#{  root.hoveredBitIDNumber }/edit"
			$(root.hoveredBit).addClass('editing')
			$("#bit_content textarea").focus() # TODO: not working ?

		else if $(root.hoveredBit).hasClass('image')
			m = showNotification "image bit - enabling zooming "
			MagicZoomPlus.start($("#MagicZoomPlus_bit_#{ root.hoveredBitIDNumber }"))
		else
			m = showNotification "unknown bit type - can't edit "

	else
		console.log "got a command hit down outside of bit"

	e.preventDefault()



), "keydown"




Mousetrap.bind "command", ( (e, combo)->

	if root.hoveredBit
		m = showNotification " #{ combo } up while hover on bit #{ root.hoveredBitIDNumber } "
		
		# disable MagicZoom only if it's an image bit
		if $(root.hoveredBit).hasClass('image')
			m = showNotification "image bit - disabling zooming "
			MagicZoomPlus.stop($("#MagicZoomPlus_bit_#{ root.hoveredBitIDNumber }"))
		else
			m = showNotification "unknown bit type - can't do anything "

	else
		m = showNotification "got a command hit up outside of bit"

	e.preventDefault()


), "keyup"


	
##########################################################################################


Mousetrap.bind ["d"], (e, combo) ->
	
	if root.hoveredBit	
		m = showNotification "pressed #{ combo } while hover on bit #{ root.hoveredBitIDNumber } "
		deleteBit()
	else
		m = showNotification "delete hit outside bit"
	e.preventDefault()


##########################################################################################

# bound to global to allow escape to work inside of the form
# requires extension: mousetrap-global-bind.min
# and _save line at end
Mousetrap.bindGlobal ["escape"], (e, combo) ->

	m = showNotification "pressed : #{ combo } : remove forms "

	$('#new_bit').remove()

	editing_bit_id = $('.editing').attr('id').split('_')[1]
	m = showNotification "editing_bit_id: #{ editing_bit_id }"

	$('.editing').remove()
	$("#data .cluster").append( $('<div>').load("/bits/#{ editing_bit_id }") )

	e.preventDefault()
	_save() 






##########################################################################################

$(document).ready ->


	$('#map').focus()

	# TODO: find a better way of keeping track of X/Y, without binding to mouse
	map = $('body').on "mousemove", (e) -> 

		root.x = e.pageX - this.offsetLeft
		root.y = e.pageY - this.offsetTop
		e.preventDefault




##########################################################################################

	map_dropzone = $("div#map").dropzone( { 
		url: "/bits" 
		clickable: false
		parallelUploads: 6
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
			this.removeFile(file)
			m = showNotification "error: tried uploading #{ file.name } : #{ response.image } ", "error"

		success: (file, response) ->
		
			this.removeFile(file)
			$("#data .cluster").append( $('<div>').load("/bits/#{   response.id  }") )
			m = showNotification "success: " + file.name + " created bit with id: " +  response.id

		sending: (file, xhr, formData) ->

			formData.append "position_x", root.x
			formData.append "position_y", root.y

			m = showNotification "sending: attaching formData for image # : [ #{ this.getQueuedFiles().length } / #{ this.getUploadingFiles().length } ] at [x][y]: [ #{ root.x }] [ #{ root.y }] : #{ file.name }"
	})

##########################################################################################

	MagicZoomPlus.options = {
		"right-click": 			"original"
		"zoom-width": 			"550"
		"zoom-height": 			"550"
		"hint-text": 			""
		"expand-speed": 		250
		"restore-speed":		250
		"initialize-on": 		"mouseover"
		"keyboard":				false
		"loading-msg":			""
		"disable-expand":		true
		"disable-zoom":			true
	}



##########################################################################################
