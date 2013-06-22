	
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


root.x = 0
root.y = 0


root.httpCodes =
	movedPermanently: 301
	pageNotFound: 404
	serverError: 500


# $('body').on "mousemove", (event) ->
# 	root.hoveredBit = $(event.target).closest('.bit')
# 	console.log "#{ root.hoveredBit.attr('id') } : x: #{ event.pageX } y: #{ event.pageY }"
# 	$('body').off "mousemove"


root.createNewBit = ->
	console.log "creating bit ... "


root.showMenu = ->
	console.log "show menu"
	console.log "#{ root.hoveredBit.attr('id') } : x: #{ root.x } y: #{ root.y }"

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



# TODO: refactor into function that handles shortcuts
# TODO: figure out scheme to prevent overlap with OS + browser keys

Mousetrap.bind ["n b", "c b"], (e, combo) ->
	m = showNotification "pressed : " + combo + " : New bit", "warning"
	console.log "root: x: #{ root.x } y: #{ root.y }"
	newBit = createNewBit()
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

	# TODO: find a better way of keeping track of X/Y, without binding to mouse
	map = $('body').on "mousemove", (e) -> 

		root.x = e.pageX - this.offsetLeft
		root.y = e.pageY - this.offsetTop

		# console.log " #{root.x} #{root.y}"
		e.preventDefault

	# TODO: ?
	# somethingElse = true

















