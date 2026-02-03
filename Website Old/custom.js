AOS.init({
  easing: 'ease-out-back',
  duration: 1000
});

$(window).scroll(function () {
        var sticky = $('.header'),
            scroll = $(window).scrollTop();
        if (scroll >= 80) sticky.addClass('menu-fixed');
        else sticky.removeClass('menu-fixed');
    });
 

var pg = window.location.pathname.substring(window.location.pathname.lastIndexOf("/") + 1);
pg = (pg === '') ? 'index.php' : pg;
$('.navbar-nav').find('[href="'+pg+'"]').closest('.nav-item').addClass('active');


$(document).ready(function() { 
$('#banner').carousel({
                interval: 5000
        }); 
});


$('#academin').owlCarousel({
    loop:false,
    margin:15,
    responsiveClass:true,
	autoplay:true,
    autoplayTimeout:4000,
	smartSpeed: 1500,
    autoplayHoverPause:false,  
	nav: false,
	dots: false,
    responsive:{
        0:{
            items:1, 
			loop:true,
        },
		680:{
            items:2, 
			loop:true,
        },
        768:{
            items:2, 
			loop:true,
        },
		992:{
            items:2,
            loop:true,
        },
		1024:{
            items:3,  
        },
        1200:{
            items:3, 
        }, 
    }
});

$('#course').owlCarousel({
    loop:true,
    margin:0,
    responsiveClass:true,
	autoplay:true,
    autoplayTimeout:4500,
	smartSpeed: 1500,
    autoplayHoverPause:false,  
	nav: true,
	dots: false,
    responsive:{
        0:{
            items:1,  
        },
		700:{
            items:2,  
        },
        768:{
            items:2,  
        },
		992:{
            items:3, 
        },
		1024:{
            items:3,  
        },
        1200:{
            items:3, 
        }, 
    }
});


$('#campus_owl').owlCarousel({
    loop:true,
    margin:15,
    responsiveClass:true,
	autoplay:true,
    autoplayTimeout:4000,
	smartSpeed: 1500,
    autoplayHoverPause:false,  
	nav: true,
	dots: false,
    responsive:{
        0:{
            items:1,  
        },
		700:{
            items:2,  
        },
        768:{
            items:2,  
        },
		992:{
            items:2, 
        },
		1024:{
            items:3,  
        },
        1200:{
            items:3, 
        }, 
    }
});

$('#event_owl').owlCarousel({
    loop:true,
    margin:0,
    responsiveClass:true,
	autoplay:true,
    autoplayTimeout:4500,
	smartSpeed: 1500,
    autoplayHoverPause:false,  
	nav: false,
	dots: false,
    responsive:{
        0:{
            items:1,  
        },
		700:{
            items:2,  
        },
        768:{
            items:2,  
        },
		992:{
            items:2, 
        },
		1024:{
            items:3,  
        },
        1200:{
            items:3, 
        }, 
    }
});



$('#testimonials').owlCarousel({
    loop:true,
    margin:0,
    responsiveClass:true,
	autoplay:true,
    autoplayTimeout:4000,
	smartSpeed: 1500,
    autoplayHoverPause:false,  
	nav: true,
	dots: false,
    responsive:{
        0:{
            items:1,  
        },
		700:{
            items:2,  
        },
        768:{
            items:2,  
        },
		992:{
            items:2, 
        },
		1024:{
            items:3,  
        },
        1200:{
            items:3, 
        }, 
    }
});




