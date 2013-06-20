
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


root.pageX = 0
root.pageY = 0

root.httpCodes =
	movedPermanently: 301
	pageNotFound: 404
	serverError: 500


# $('body').on "mousemove", (event) ->
# 	root.hoveredElement = $(event.target).closest('.bit')
# 	console.log "#{ root.hoveredElement.attr('id') } : x: #{ event.pageX } y: #{ event.pageY }"
# 	$('body').off "mousemove"


root.createNewBit = ->
	console.log "creating bit ... "


root.showMenu = ->
	console.log "showMenu call"


# TODO: better way to get the hovered element? 


root.showNotification = (message, type) ->

	$.pnotify
	  text: message
	  shadow: false
	  animation: 'fade'
	  type: 'info'


# TODO: refactor into function that handles shortcuts
# TODO: figure out scheme to prevent overlap with OS + browser keys
# TODO: is there a  way to get the mouse position without binding 
Mousetrap.bind ["command"], (e, combo) ->
	m = showNotification "pressed : " + combo + " : modifier ... ", "warning"
	# console.log root.hoveredElement


Mousetrap.bind ["n b", "c b"], (e, combo) ->
	m = showNotification "pressed : " + combo + " : New bit", "warning"
	console.log "x: #{ root.pageX } y: #{ root.pageY }"
	newBit = createNewBit()
	e.preventDefault




$(document).ready ->

	map = $('#map').on "mousemove", (e) -> 
		root.pageX = e.pageX
		root.pageY = e.pageY
		e.preventDefault

	somethingElse = true








