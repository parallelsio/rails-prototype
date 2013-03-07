$(document).ready(function()
{
	
	// d3.select("#sm2-container").insert("svg", ":first-child")
 //           .attr("width", 500)
 //           .attr("height", 50);


    soundManager.setup({
      url: '/swf/',
      flashVersion: 8, // optional: shiny features (default = 8)
      useFlashBlock: false
      
    });



	threeSixtyPlayer.config = {
	  playNext: false, // stop after one sound, or play through list until end
	  autoPlay: false, // start playing the first sound right away
	  allowMultiple: true, // let many sounds play at once (false = one at a time)
	  loadRingColor: '#ccc',// amount of sound which has loaded
	  playRingColor: '#000', // amount of sound which has played
	  showHMSTime: true,
	  useEQData: true,
	  useWaveformData: true,
	  backgroundRingColor: '#eee', // "default" color shown underneath everything else
	  animDuration: 500,
	  animTransition: Animator.tx.bouncy// http://www.berniecode.com/writing/animator.html
	}





	$('#play_opening').click(function(){
		
		var soundObject = soundManager.createSound({
		 id:'opening',
		 url:'/sounds/opening-v1.mp3'
		
		});

		soundObject.play();
		return false;
	});



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


	$("._21").click(function(){
  		$("._21 .content").animate({	
  				top: 	'-=20px',
  			 	left: 	'+=183px'  },
  			 "slow",
  			 function(){
               //$(this).html("Animation Completed");
               $(this).unbind('click');  }
  		);
	}); 


    $('._23').click(function(){

    	


        var add = $(this).find('.card').addClass('flipped')

        var soundObject = soundManager.createSound({
		 id:'flip_in',
		 url:'/sounds/aim_buddy_logging_in.mp3'
		
		});
		soundObject.play();

		add.mouseleave(function(){
            $(this).removeClass('flipped');

           	var soundObject = soundManager.createSound({
			 id:'flip_out',
			 url:'/sounds/aim_buddy_logging_out.mp3'
			
			});
			soundObject.play();


        });
        return false;
    });

	$('._25 .content').hover(function(){
				$(this).removeClass('before');

				var soundObject = soundManager.createSound({
				 id:'cut',
				 url:'/sounds/cut.mp3'
				
				});
				soundObject.play();

			},function(){
						  $(this).unbind('hover'); 
						

			});
			



	$('._29 .content').hover(function(){
				$(this).addClass('after');

				var soundObject = soundManager.createSound({
				 id:'glue',
				 url:'/sounds/glue.mp3'
				
				});
				soundObject.play();

			},function(){
						  $(this).unbind('hover'); 
						

			});




			


});

