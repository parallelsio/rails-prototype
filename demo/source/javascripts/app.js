$(document).ready(function()
{



	Mousetrap.bind('1', function() { 

	//	highlight(2); 
	  $("._700-1").fadeIn(500, function showNext() 
	  {
	    $("._701-1").fadeIn(500, function showNext() 
	    {
	  		$(".search_trigger .one").fadeIn(500);
	  	});	
	  });


	});



	
	// keycommands 
	// $(".content").mouseover(function(){

			
	// 		Mousetrap.bind('tab', function(e, element){
	// 		    console.log(e);
			    

	// 		    // This is not working
	// 		    // $(this).attr('id').effect("highlight", {}, 3000);
			    
	// 		    return false;
	// 			});


 //    	// $(this).removeClass().addClass("hover");
 //    }).mouseout(function(){

 //    	// $(this).removeClass().addClass("hover");		
 //    	Mousetrap.reset();
 //    });



	/* d3 test */
	// d3.select("#sm2-container").insert("svg", ":first-child")
 //           .attr("width", 500)
 //           .attr("height", 50);


    soundManager.setup({
      url: '/swf/',
      flashVersion: 8, // optional: shiny features (default = 8)
      useFlashBlock: false
      
    });



    /* UI config for sound bit */
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




	/* play sound bit */
	$('#play_opening').click(function(){
		
		var soundObject = soundManager.createSound({
		 id:'opening',
		 url:'/sounds/opening-v1.mp3'
		
		});

		soundObject.play();
		return false;
	});



	$( ".content" ).draggable({ handle: "p" });

	/* buggy, snap */
	// $( ".content" ).draggable({ handle: "p" , snap: ".content" });

	



	/* flip bit, sounds */
    $('._23').click(function(){

        var add = $(this).find('.card').addClass('flipped')

  //       var soundObject = soundManager.createSound({
		//  id:'flip_in',
		//  url:'/sounds/aim_buddy_logging_in.mp3'
		
		// });
		// soundObject.play();

		add.mouseleave(function(){
            $(this).removeClass('flipped');

   //         	var soundObject = soundManager.createSound({
			//  id:'flip_out',
			//  url:'/sounds/aim_buddy_logging_out.mp3'
			
			// });
			// soundObject.play();


        });
        return false;
    });

    /* cut sound for split bit */
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
			


	/* sound on glue bits */
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



    $('#zelda_large').imgAreaSelect({
        handles: true,
        parent: '#center',
        autoHide: true,
        onSelectEnd: function(){
               $('#zelda_large').css('display', "none");
               $('#zelda_cropped').css('display', "block");
                 }
	});


	/* sound on glue bits */
	$('._38-1').click(function(){
			
				$('._38-6').css('display', "block");
						

			});




	
			

	$('._32-2 .content').click(function(){

         $('.bit._32-2').css('display', "none");
         $('.sliced_text').css('display', "block");
	});						

				
	$('._32-4 .content').click(function(){

         $('.bit._32-4').css('display', "none");
         $('.umberto').css('display', "block");
	});						




	$('.weightless_topic ._68-1').click(function(){

         $(this).css('left', '-270px');
         $(this).css('top', '-1420px');
         

         
	});		


				
	$('._36-3 img').click(function(){
		$(this).attr('src', '/images/slider2.jpg');
		 $('.bit._32-4').css('display', "block");
         $('.umberto').css('display', "none");
         $('._32-4 .content').unbind('click');  
	});						

	$('._38-1 .content').click(function(){
		 $('._38-6').css('display', "block");
         
	});	




	$('.row_search').click(function(){

		$('._131 img').hide();
		$('._131 img').attr('src', '/images/search_1.png').slideDown("fast");

		  $("._132 img").show();
		  $("._133").fadeIn(1000, function showNext() 
		  {
		    $("._134").fadeIn(1000);
		  	$("._132 img").hide();
		  });
		

	});	






    $('._145 img').imgAreaSelect({
        handles: true,
        parent: '#center',
        autoHide: true,
        onSelectEnd: function(){
	               $('._145').animate({	
		  			 	left: 	'-=464px'  },
		  			 "slow",
		  			 function(){

		               	$(this).unbind('click');  

						
						// $(this).attr('src', '/images/search_1.png').slideDown("fast");

						  $("._201 .left").fadeIn(500, function showNext() 
						  {
						    $("._201 .middle").fadeIn(500, function showNext() 
						    {
						  		$("._201 .right").fadeIn(500);
						  	});	
						  });
						

		           });


               		$('._111-1').show().fadeIn(1000);
                 }
	});







	/* flip bit, sounds */
    $('._111-1').click(function(){

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









    $('._112-1').click(function(){

		
		  $("._202 .middle").fadeIn(500, function showNext() 
		  {
		    $("._202 .two").fadeIn(500);
		  });
	});


    $('._202 .two').click(function(){

		  $("._112-7").fadeIn(500); 
		
		  $("._202 .one").fadeIn(500); 
	
	});



     $('.search_trigger').click(function(){



		  $(".search").fadeIn(100);
		  $("._900").fadeIn(100);
	});








    /* cut sound for split bit */
	$('.search_trigger .one').click(function(){
				
				  $('.search_trigger ._120').animate({left:'-=180', top:'+=120'},200);
				  $('.search_trigger ._122').animate({left:'+=0', top:'+=110'},200);
				  $('.search_trigger ._123').animate({left:'+=20', top:'+=260'},200);

			});
			



	Mousetrap.bind('2', function() { 

	  $('.search_trigger ._120').animate({left:'+=180', top:'-=120'},200);
	  $('.search_trigger ._122').animate({left:'-=0', top:'-=110'},200);
	  $('.search_trigger ._123').animate({left:'-=20', top:'-=260'},200);

	});
	




});

