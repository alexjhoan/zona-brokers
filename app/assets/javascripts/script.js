is_mobile = false;

$( window ).on('scroll', function() {
  if ($(window).scrollTop() > 1630) {
    $('.property-details.style-4 .side-section').addClass('static');
  } else {
    $('.property-details.style-4 .side-section').removeClass('static');
  }
});

$( document ).on('ready', function() {
  $(window).scrollTop(0);

  if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
    is_mobile = true
    $('.home-banner').css('height',$(window).innerHeight() - 60)
    $('.visible-mobile').removeClass('hidden');
  }

  $('.owl-carousel').on('touchmove', function() {
    $('body').css('overflow','hidden');
  });

  $('.owl-carousel').on('touchend', function() {
    $('body').css('overflow','scroll');
  });

  $('#property_location_column select').multiselect({
    buttonWidth: '100%',
    enableFiltering: true,
    maxHeight: 400,
    enableCaseInsensitiveFiltering: true,
    nonSelectedText: 'Ubicación ej.: Pocitos, Montevideo'
  });

  if (is_mobile) {
    $('#property_location_column ul').append(
      "<div class='close-button'><button type='button'> Aceptar </button></div>"
    );
  }

  $('.filters-header select.multiple, .listings-header select.multiple').multiselect({
    buttonWidth: '100%',
    maxHeight: 400,
    nonSelectedText: ''
  });

  if (is_mobile) {
    $('select').removeClass('custom-select-box');
    $('html, body').css('min-height', window.innerHeight);
    $('.filters-header .datepicker').attr('type', 'date');
  } else {
    $('.datepicker').datepicker({
      format: 'yyyy-mm-dd',
      startDate: 'dd',
      language: 'es',
      widgetPositioning: {
        horizontal: 'right',
        vertical: 'bottom'
      }
    });

    $('#operation_type_name_select').multiselect({
      buttonWidth: '100%',
      maxHeight: 400,
      nonSelectedText: ''
    });

    $('#property_type_id_select').multiselect({
      buttonWidth: '100%',
      maxHeight: 400,
      nonSelectedText: 'Tipo de propiedad'
    })
  }

  $('.close-modal').on('click', function(){
    $(this).closest(".modal").addClass('hidden');
    enableScroll();
  })

  $('.modal-background').on('click', function(){
    $(this).parent().closest(".modal").addClass('hidden')
    enableScroll();
  })

  $('#flash-messages .alert').delay(5000).fadeOut(500)

  $('.consult-messages').delay(5000).fadeOut(500)

  // Welcome

  $('#operation_type_name_select').on('change', function(){
    if($(this).val() == 'alquiler-temporal') {
      $('#property_type_column').addClass('hidden');
      $('#property_location_column').addClass('col-sm-4 col-md-5');
      $('#property_location_column').removeClass('col-sm-6 col-md-6');
      $('#operation_type_column').addClass('col-xs-12');
      $('#operation_type_column').removeClass('col-xs-6');
      $('#property_start_date_column').removeClass('hidden');
      $('#property_end_date_column').removeClass('hidden');
      $('#property_type_id_select').prop('required',false);
      $('#from_date_id').prop('name','from_date');
      $('#to_date_id').prop('name','to_date');
    } else {
      $('#property_type_column').removeClass('hidden');
      $('#property_location_column').addClass('col-sm-6 col-md-6');
      $('#property_location_column').removeClass('col-sm-4 col-md-4');
      $('#operation_type_column').addClass('col-xs-6');
      $('#operation_type_column').removeClass('col-xs-12');
      $('#property_start_date_column').addClass('hidden');
      $('#property_end_date_column').addClass('hidden');
      $('#property_type_id_select').prop('required',true);
      $('#from_date_id').prop('name','');
      $('#to_date_id').prop('name','');
    }
  });

  $(document).on('click', '.property-listing li.filter' , function(){
    $('.property-listing .filter-list .loader').removeClass('hidden');
    $('.property-listing .filter-list .property-box').remove();
    $.get('/properties/highlighted.js', {
      IDoperaciones: $(this).attr('data-value')
    })
  })

  $('.home-banner form.properties-search').on('submit', function(){
    $('.home-banner form').attr('action',
      '/' + $('#operation_type_name_select').val()
    );
  })

  // Hide Loading Box
  function handleLoader() {
    if($('.loader.fullscreen').length){
      $('.loader.fullscreen').delay(200).fadeOut(500);
    }
  }

  // Update Header Style and Scroll to Top
  function headerStyle() {
    if($('.main-header').length){
      var windowpos = $(window).scrollTop();
      var siteHeader = $('.main-header');
      var scrollLink = $('.scroll-to-top');
      if (windowpos >= 200) {
        siteHeader.addClass('fixed-header');
        scrollLink.fadeIn(300);
      } else {
        siteHeader.removeClass('fixed-header');
        scrollLink.fadeOut(300);
      }
    }
  }

  headerStyle();

  // Submenu Dropdown Toggle
  if($('.main-header .navigation li.dropdown ul').length){
    $('.main-header .navigation li.dropdown').append('<div class="dropdown-btn"><span class="fa fa-angle-down"></span></div>');

    // Dropdown Button
    $('.main-header .navigation li.dropdown .dropdown-btn').on('click', function() {
      $(this).prev('ul').slideToggle(500);
    });

    // Disable dropdown parent link
    $('.main-header .navigation li.dropdown > a,.hidden-bar .side-menu li.dropdown > a').on('click', function(e) {
      e.preventDefault();
    });
  }

  // Home highlights Carousel
  $('.carousel-highlights-container .images-carousel').owlCarousel({
    loop: false,
    margin: 50,
    smartSpeed: 2000,
    autoplay: true,
    autoplayTimeout: 5000,
    dots: false,
    nav: true,
    dots: true,
    items: 1
  });

  // Banners Carousel
  if (is_mobile) {
    $('.banners-carousel').addClass('owl-carousel');
    $('.banners-carousel').addClass('owl-theme');
    $('.banners-carousel').owlCarousel({
      loop: false,
      margin: 50,
      smartSpeed: 2000,
      autoplay: true,
      autoplayTimeout: 5000,
      dots: false,
      nav: true,
      items: 1
    });
  }

  // Links Carousel
  if ($('.links-carousel').length) {
    $('.links-carousel').owlCarousel({
      loop: true,
      margin: 50,
      smartSpeed: 700,
      autoplay: 5000,
      dots: true,
      items: 1
    });
  }

  // Property Details Carousel
  if ($('.prod-image-carousel').length && $('.prod-thumbs-carousel').length) {
    var $sync1 = $(".prod-image-carousel");
    var $sync2 = $(".prod-thumbs-carousel");
    var flag = false;
    var duration = 500;
    $sync1.owlCarousel({
      loop: false,
      items: 1,
      margin: 5,
      nav: false,
      dots: true,
      smartSpeed: 700,
      autoplay: true,
      autoplayTimeout: 5000
    }).on('changed.owl.carousel', function (e) {
      if (!flag) {
        flag = false;
        $sync2.trigger('to.owl.carousel', [e.item.index, duration, true]);
        flag = false;
      }
    });

    $sync2.owlCarousel({
      loop: false,
      margin: 5,
      items: 1,
      nav: true,
      dots: false,
      center: false,
      smartSpeed: 700,
      autoplay: true,
      autoplayTimeout: 5000,
      responsive: {
        0: {
          items:2,
          autoWidth: false
        },
        400: {
          items:4,
          autoWidth: false
        },
        500: {
          items:5,
          autoWidth: false
        },
        600: {
          items:6,
          autoWidth: false
        },
        800: {
          items:7,
          autoWidth: false
        },
        900: {
          items:8,
          autoWidth: false
        },
        992: {
          items:6,
          autoWidth: false
        },
        1000: {
          items:7,
          autoWidth: false
        },
        1200: {
            items:8,
            autoWidth: false
        }
      },
    })
    .on('click', '.owl-item', function () {
      $sync1.trigger('to.owl.carousel', [$(this).index(), duration, true]);
    })
    .on('changed.owl.carousel', function (e) {
      if (!flag) {
        flag = true;
        $sync1.trigger('to.owl.carousel', [e.item.index, duration, true]);
        flag = false;
      }
    });
  }

  $('.property-box').on('click', '.owl-prev, .owl-next', function(event) {
    event.stopPropagation();
    event.preventDefault();
  });

  //LightBox / Fancybox
  if($('.lightbox-image').length) {
    $('.lightbox-image').fancybox({
      openEffect  : 'fade',
      closeEffect : 'fade',
      helpers : {
        media : {}
      }
    });
  }

  // Translate html5 form validation messages

  $('input:required').on('change invalid', function() {
    var input = $(this).get(0);
    input.setCustomValidity('');

    if (!input.validity.valid) {
      input.setCustomValidity('Por favor ingresa este campo.');
    }
  });

  // When document is Scrollig, do

  $(window).on('scroll', function() {
    headerStyle();
  });

  // When document is loading, do

  $(window).load(function () {
    handleLoader();
    $('#property-map').addClass('hidden');
    $('#property-panoramic').addClass('hidden');
  });
})

function disableScroll() {
  $('body').css('overflow','hidden');
  $('body').css('position','fixed');
}

function enableScroll() {
  $('body').css('overflow','scroll');
  $('body').css('position','static');
}
