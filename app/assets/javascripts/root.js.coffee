
root = global ? window

# ############## SETUP  ***********************
# soundManager.setup
#   url: "/swf/"
#   flashVersion: 8 # optional: shiny features (default = 8)
#   useFlashBlock: false


# # UI config for sound bit 
# threeSixtyPlayer.config =
#   playNext: false # stop after one sound, or play through list until end
#   autoPlay: false # start playing the first sound right away
#   allowMultiple: true # let many sounds play at once (false = one at a time)
#   loadRingColor: "#ccc" # amount of sound which has loaded
#   playRingColor: "#000" # amount of sound which has played
#   showHMSTime: true
#   useEQData: true
#   useWaveformData: true
#   backgroundRingColor: "#eee" # "default" color shown underneath everything else
#   animDuration: 500
#   animTransition: Animator.tx.bouncy # http://www.berniecode.com/writing/animator.html



# keep track of current mouse position
root.x = 0
root.y = 0


root.httpCodes =
	movedPermanently: 301
	pageNotFound: 404
	serverError: 500



# text bits require a form
# images just get dragged and dropped (no form)
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
	# keep track of mouse position,
	# when bit:new/create, use mouse position to create bit
	map = $('body').on "mousemove", (e) -> 

		root.x = e.pageX - this.offsetLeft
		root.y = e.pageY - this.offsetTop

		# console.log " #{root.x} #{root.y}"
		e.preventDefault



	$('#map').fileupload( {
		url: '/bits'
		dropZone: '#new_image'
		limitMultiFileUploads: 10

    	# TODO: how to send as params[:bit][:position_y]?
    	# TODO: set up as callback
		formData: {
			position_x: root.x
			position_y: root.y
		}
	})










