
//= require_tree .

$(document).ready(function()
{

	$( ".content" ).draggable({ handle: "p" });

	/*
	
	$(".content").mouseover(function(){

			
			Mousetrap.bind('tab', function(e, element){
			    console.log(e);
			    

			    // This is not working
			    // $(this).attr('id').effect("highlight", {}, 3000);
			    
			    return false;
				});


    	// $(this).removeClass().addClass("hover");
    }).mouseout(function(){

    	// $(this).removeClass().addClass("hover");		
    	Mousetrap.reset();
    });

	*/


	threeSixtyPlayer.config = {
	  playNext: false, // stop after one sound, or play through list until end
	  autoPlay: false, // start playing the first sound right away
	  allowMultiple: true, // let many sounds play at once (false = one at a time)
	  loadRingColor: '#ccc',// amount of sound which has loaded
	  playRingColor: '#000', // amount of sound which has played
	  backgroundRingColor: '#eee', // "default" color shown underneath everything else
	  animDuration: 500,
	  animTransition: Animator.tx.bouncy// http://www.berniecode.com/writing/animator.html
	}



});


