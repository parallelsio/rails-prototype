##########################################################################################
root = global ? window
##########################################################################################

# keep track of current mouse position
# used when bit:new/create, use mouse position to create bit at that location
root.x = 0
root.y = 0


root.show_notifications = true



##########################################################################################

# text bits require a form
root.createNewTextBit = ->

  request = $.ajax( 
  	url: '/bits/new'
  	type: 'GET'
  	data: {
	    		position_x: root.x
	    		position_y: root.y
	    		map_id: window.location.hash.split('/')[2]
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
root.shatterBit = ->

	console.log "inside shatterBit"

	# pulse to indicate processing
	$(root.hoveredBit).addClass('pulse_load')

	request = $.ajax( 
		url: '/bits/' + root.hoveredBitIDNumber + '/shatter'
		type: 'POST'
		data: {
	  		position_x: root.x
	  		position_y: root.y
	  		number_of_tiles_across: 4
	  		number_of_tiles_tall: 4
	  	}
	)

	request.done (data) -> 
		m = showNotification "shattered bit_#{ root.hoveredBitIDNumber }"

 	return true 
  
  
##########################################################################################
root.cropImageBit = ->

	console.log "inside cropImageBit"

	# attach crop handler
	$("#bit_#{ root.hoveredBitIDNumber } .face.front .content .zoom a img").imgAreaSelect 
    	handles: true
    	movable: false
    	keys: false
    	parent: $("#bit_#{ root.hoveredBitIDNumber }")

    	onInit: ->
    		console.log "crop set up now for bit_id_number: #{  root.hoveredBitIDNumber }"
    		$("#bit_#{ root.hoveredBitIDNumber }:hover").addClass('crop_cursor')
    		true

    	onSelectEnd: (img, selection) ->

    		# TODO: how to access root.hoveredBitIDNumber here?
    		bit_id_number = $(img).attr('id').split('_')[2]

    		console.log "crop selection made: top left: [x: #{ selection.x1  } y: #{ selection.y1 }] bottom right: x: #{ selection.x2  } y: #{ selection.y2 }] bit_id_number: #{  bit_id_number }"

    		# pulse to indicate processing
    		$("#bit_#{ bit_id_number }").addClass('pulse_load')

    		request = $.ajax( 
    			url: '/bits/' + bit_id_number + '/crop'
    			type: 'POST'
    			data: {
    				selection: selection

    				# send the thumbnail size, as we never stored it in the model
    				# only storing the full size dimensions
    				# to call imagemagick identify is too expensive
    				# it's already available here via browser as computed style
    				thumb_image_height: document.getElementById("bit_image_#{ bit_id_number}").offsetHeight
    				thumb_image_width: document.getElementById("bit_image_#{ bit_id_number }").offsetWidth
    			}
    		)

    		request.done (data) -> 
    			m = showNotification "crop bit_#{ bit_id_number }"

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

	if root.show_notifications
		$.pnotify
		  text: message
		  shadow: false
		  animation: 'fade'
		  type: type
		  delay: 1500

	console.log message


##########################################################################################

# 		BIT : NEW TEXT

# TODO: refactor into function that handles shortcuts
# TODO: figure out key commands to prevent overlap with OS + browser keys
Mousetrap.bind ["n b", "c b"], (e, combo) ->
	m = showNotification "pressed : #{ combo } : new bit at x: #{ root.x } y: #{ root.y }"
	# console.log "root: x: #{ root.x } y: #{ root.y }"
	newTextBit = createNewTextBit()
	e.preventDefault()


##########################################################################################

# 		BIT : TEXT EDIT
#		BIT : IMAGE ZOOM

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
		else
			m = showNotification "unknown bit type - can't edit ", "warning"

	else
		console.log "got a command hit down outside of bit"

	e.preventDefault()

), "keydown"




Mousetrap.bind "command", ( (e, combo)->

	if root.hoveredBit
		m = showNotification " #{ combo } up while hover on bit #{ root.hoveredBitIDNumber } "
		
		if $(root.hoveredBit).hasClass('image')
			m = showNotification "image bit - disabling zooming "
	else
		m = showNotification "got a command hit up outside of bit"

	e.preventDefault()


), "keyup"


	
##########################################################################################

# 		BIT : DELETE

Mousetrap.bind ["d"], (e, combo) ->
	
	if root.hoveredBit	
		$(root.hoveredBit).addClass('pulse_load')
		m = showNotification "pressed #{ combo } while hover on bit #{ root.hoveredBitIDNumber } "
		deleteBit()
	else
		m = showNotification "delete hit outside bit"
	e.preventDefault()

##########################################################################################

# 		BIT : SHATTER

Mousetrap.bind ["s"], (e, combo) ->

	if $(root.hoveredBit).hasClass('text')
		m = showNotification "pressed #{ combo } for shatter, text #{ root.hoveredBitIDNumber } "

	else if $(root.hoveredBit).hasClass('image')
		m = showNotification "pressed #{ combo } for shatter, image #{ root.hoveredBitIDNumber } "
		shatterBit()

	else
		m = showNotification "pressed #{ combo } for shatter, unknown bit type", "warning"


##########################################################################################

# 		HIDE BIT : TEXT : NEW FORM

# bound to global to allow escape to work inside of the form
# requires extension: mousetrap-global-bind.min
# and _save line at end
Mousetrap.bindGlobal ["escape"], (e, combo) ->

	m = showNotification "pressed : #{ combo } : remove forms "

	$('#new_bit').remove()

	editing_bit_id = $('.editing').attr('id').split('_')[1]
	m = showNotification "editing_bit_id: #{ editing_bit_id }"

	$('.editing').remove()
	$("#map").append( $('<div>').load("/bits/#{ editing_bit_id }") )

	e.preventDefault()
	_save() 




##########################################################################################

# 		BIT : IMAGE : CROPc

Mousetrap.bind ["c"], (e, combo) ->

	if $(root.hoveredBit).hasClass('text')
		m = showNotification "pressed #{ combo } for crop, text #{ root.hoveredBitIDNumber } "

	else if $(root.hoveredBit).hasClass('image')
		m = showNotification "pressed #{ combo } for crop, image #{ root.hoveredBitIDNumber } "
		cropImageBit()

	else
		m = showNotification "pressed #{ combo } for crop, unknown bit type", "warning"










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
			$("#map").append( $('<div>').load("/bits/#{   response.id  }") )
			m = showNotification "success: " + file.name + " created bit with id: " +  response.id

		sending: (file, xhr, formData) ->

			formData.append "position_x", root.x
			formData.append "position_y", root.y

			m = showNotification "sending: attaching formData for image # : [ #{ this.getQueuedFiles().length } / #{ this.getUploadingFiles().length } ] at [x][y]: [ #{ root.x }] [ #{ root.y }] : #{ file.name }"
	})

##########################################################################################

