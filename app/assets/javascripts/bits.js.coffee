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
	    	message = "bit #{ data.id } position saved: x: #{ data.position_x } y: #{ data.position_y }"
	    	type = "warning"
	    	showNotification(message, type)
	    	true

	    request.fail (data) -> $('#notice').text "bit #{ data.id } position save failed "

	    true

	#############################################################

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

	MagicZoomPlus.stop()
	

	# adapted from :
	# http://thiscouldbebetter.wordpress.com/2012/02/25/slicing-an-image-into-tiles-in-javascript/
	# ImageSlicingTest = ->
	#   main2 = (event) ->
	#     imageToSlice = event.target
	#     imageTiles = new ImageHelper().sliceImageIntoTiles(imageToSlice, new Coords(4, 1))
	#     imageTileSize = new Coords(imageTiles[0].width, imageTiles[0].height)
	#     i = 0

	#     while i < imageTiles.length
	#       imageTile = imageTiles[i]
	#       drawPos = new Coords(i * 2, 0).multiply(imageTileSize)
	#       imageTile.style.left = drawPos.x
	#       imageTile.style.top = drawPos.y
	#       document.body.appendChild imageTile
	#       i++
	#   @main = ->
	#     imageToSlice = new Image()
	#     imageToSlice.onload = main2
	#     imageToSlice.src = "RedGreenBlueYellow.png"
	# Coords = (x, y) ->
	#   @x = x
	#   @y = y
	#   @clone = ->
	#     new Coords(@x, @y)

	#   @divide = (other) ->
	#     @x /= other.x
	#     @y /= other.y
	#     this

	#   @multiply = (other) ->
	#     @x *= other.x
	#     @y *= other.y
	#     this

	#   @overwriteWith = (other) ->
	#     @x = other.x
	#     @y = other.y
	#     this

	#   @toString = ->
	#     "(" + @x + "," + @y + ")"
	# ImageHelper = ->
	#   @sliceImageIntoTiles = (imageToSlice, sizeInTiles) ->
	#     returnImages = new Array()
	#     imageToSliceSize = new Coords(imageToSlice.width, imageToSlice.height)
	#     tileSize = imageToSliceSize.clone().divide(sizeInTiles)
	#     tilePos = new Coords(0, 0)
	#     sourcePos = new Coords(0, 0)
	#     y = 0

	#     while y < sizeInTiles.y
	#       tilePos.y = y
	#       x = 0

	#       while x < sizeInTiles.x
	#         tilePos.x = x
	#         canvas = document.createElement("canvas")
	#         canvas.id = "tile_" + x + "_" + y
	#         canvas.width = tileSize.x
	#         canvas.height = tileSize.y
	#         canvas.style.position = "absolute"
	#         graphics = canvas.getContext("2d")
	#         sourcePos.overwriteWith(tilePos).multiply tileSize
	#         # source pos
	#         # source size
	#         # destination pos
	#         graphics.drawImage imageToSlice, sourcePos.x, sourcePos.y, tileSize.x, tileSize.y, 0, 0, tileSize.x, tileSize.y # destination size
	        
	#         # browser dependent?
	#         imageFromCanvasURL = canvas.toDataURL("image/png")
	#         imageFromCanvas = document.createElement("img")
	#         imageFromCanvas.width = canvas.width
	#         imageFromCanvas.height = canvas.height
	#         imageFromCanvas.style.position = "absolute"
	#         imageFromCanvas.src = imageFromCanvasURL
	#         returnImages.push imageFromCanvas
	#         x++
	#       y++
	#     returnImages
	# program = new ImageSlicingTest()
	# program.main()




	##############################################################












