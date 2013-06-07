
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



	root.showMenu = ->
		alert



	root.showNotification = (message, type, id) ->

		$.pnotify
		  text: message
		  shadow: false
		  animation: 'fade'
		  type: 'info'
		  hide: false




	Mousetrap.bind ["command+k"], (e, combo) ->
	  m = showNotification "pressed : " + combo, "warning", e.id
	  e.preventDefault


	Mousetrap.bind ["command"], (e, combo) ->
	  m = showNotification "pressed : " + combo, "warning", e.id
	  e.preventDefault
















