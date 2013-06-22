	
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




root.httpCodes =
	movedPermanently: 301
	pageNotFound: 404
	serverError: 500


# $('body').on "mousemove", (event) ->
# 	root.hoveredBit = $(event.target).closest('.bit')
# 	console.log "#{ root.hoveredBit.attr('id') } : x: #{ event.pageX } y: #{ event.pageY }"
# 	$('body').off "mousemove"


root.showMenu = ->
	console.log "show menu"
	console.log "#{ root.hoveredBit.attr('id') } : x: #{ event.pageX } y: #{ event.pageY }"

	# TODO: 
	# get size of the bit
	# calc position for menu
	# animate it out
	# pulsate? wiggle?

	#display temp toolbar
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




Mousetrap.bind ["n b"], (e, combo) ->
	m = showNotification "pressed : " + combo + " : New bit", "warning"

	console.log " x: #{ event.pageX } y: #{ event.pageY }"
	e.preventDefault



Mousetrap.bind ["command"], (e, combo) ->
	
	

	if root.hoveredBit
		console.log "got a command hit inside"
		m = showNotification "pressed #{ combo } while hover on #{ root.hoveredBit.attr('id') } ", "warning"
		showMenu()


	else
		console.log "got a command hit outside"


	e.preventDefault
	












$(document).ready ->












