$( document ).on('ready', function() {
  $('.price-filter a').on('click', function() {
    var new_href = $(this).attr('href');
    new_href = new_href.replace(/(&|\?)(min_price|max_price)=[0-9]*/g, "");
    new_href += (new_href.indexOf("?") >= 0) ? '&' : '?';
    new_href += 'min_price=' + $('#min_price_input').val();
    new_href += (new_href.indexOf("?") >= 0) ? '&' : '?';
    new_href += 'max_price=' + $('#max_price_input').val();
    $(this).attr('href', new_href);
  })

  $('.date-filter a').on('click', function() {
    var new_href = $(this).attr('href');
    new_href = new_href.replace(/(&|\?)(from_date|to_date)=[0-9]*/g, "");
    if ($('#from_date_input').val()) {
      new_href += (new_href.indexOf("?") >= 0) ? '&' : '?';
      new_href += 'from_date=' + $('#from_date_input').val();
    }
    if ($('#to_date_input').val()) {
      new_href += (new_href.indexOf("?") >= 0) ? '&' : '?';
      new_href += 'to_date=' + $('#to_date_input').val();
    }
    $(this).attr('href', new_href);
  })

  $('.currency-filter button').on('click', function(){
    $('.currency-filter button').addClass('empty');
    $(this).removeClass('empty');
    var link = $('.price-filter a')
    var new_href = link.attr('href');
    new_href = new_href.replace(/(&|\?)currency_id=(1|2)/g, "");
    new_href += (new_href.indexOf("?") >= 0) ? '&' : '?';
    new_href += 'currency_id=' + $(this).attr('data-value');
    link.attr('href', new_href);
  })

  $('.zones-modal .zone-checkbox-filter').on('keyup', function() {
    filter = $(this).val();
    $('.zones-modal .options-container .zone').addClass('hidden');
    $('.zones-modal .options-container .zones-by-letter').addClass('hidden');
    $.each($('.zones-modal .options-container .zone'), function( index, value ) {
      if ($(this).attr('data-filter').match(new RegExp(filter, "i"))) {
        $(this).removeClass('hidden');
      }
    })
    $.each($('.zones-modal .options-container .zones-by-letter'), function( index, value ) {
      if ($(this).children('.zone').not('.hidden').length > 0) {
        $(this).removeClass('hidden');
      }
    })
  })

  $('.zones-modal .deselect').on('click', function(){
    $('.zones-modal .options-container .checkbox').attr('checked', false);
  })

  if ($(location).attr('href').indexOf('state_id') == -1) {
    $('.zones-modal .options-container .checkbox').on('click', function() {
      $('.zones-modal .options-container .checkbox').not(this).attr('checked', false);
    });
    $('.zones-modal .options-container .name').on('click', function() {
      if ($(this).prev('.checkbox').is(':checked')) {
        $(this).prev('.checkbox').attr('checked', false)
      } else {
        $('.zones-modal .options-container .checkbox').attr('checked', false);
        $(this).prev('.checkbox').prop('checked', true)
      }
    });
  } else {
    $('.zones-modal .options-container .name').on('click', function() {
      if ($(this).prev('.checkbox').is(':checked')) {
        $(this).prev('.checkbox').attr('checked', false)
      } else {
        $(this).prev('.checkbox').prop('checked', true)
      }
    });
  }

  $('.zones-modal button.submit').on('click', function() {
    var new_href = decodeURIComponent(window.location.href);
    new_href = new_href.replace(/zone_id\[\]=[0-9]*(?:$|&)/g, "");
    new_href = new_href.replace(/page=[0-9]*(?:$|&)/g, "");
    var zone_regex = /.*\/\/.*\/.*\/.*\/.*(\/.*)$/g;
    var zones = zone_regex.exec(new_href);
    if (zones) {
      new_href = new_href.replace(zones[1], "")
    }
    $.each($('.zones-modal .options-container .checkbox'), function( index, value ) {
      if($(this).is(':checked')) {
        if ($(location).attr('href').indexOf('state_id') == -1) {
          var id = 'state_id='
        } else {
          var id = 'zone_id[]='
        }
        new_href += (new_href.indexOf("?") >= 0) ? '&' + id : '?' + id;
        new_href += $(this).attr('name');
      }
    })
    window.location.replace(new_href);
    enableScroll();
  })

  $('.sidebar .filter-container .filter.search').on('click', function() {
    $('.zones-modal').removeClass('hidden');
    disableScroll();
  })

  $('#list-order-mobile, #list-order').on('change', function() {
    var new_href = window.location.href;
    new_href = new_href.replace(/(&|\?)list_order=[0-9]?/g, "");
    new_href += (new_href.indexOf("?") >= 0) ? '&' : '?';
    new_href += 'list_order='
    new_href += $(this).val();
    window.location.replace(new_href);
  })

  $('.sidebar-container .sidebar-toggler').on('click', function() {
    $('.properties-search-section .side-section').css('display', 'none')
  })

  $('.filters-header button.show-sidebar').on('click', function(){
    $('.properties-search-section .side-section').css('display', 'block')
  })

  $('.property-box .image-box').mouseenter(function() {
    if ($(this).find('.images-carousel').not('.looked-up').length){
      $(this).find('.loader').removeClass('hidden');
      $(this).find('.images-carousel').addClass('looked-up');
      $.get('/properties/' + $(this).closest('.property-box').attr('data-id') + '/images.js');
    }
    else if ($(this).find('.loader').not('hidden').length) {
      $(this).find('.images-carousel').removeClass('hidden');
      $(this).find('.owl-nav').removeClass('hidden');
    }
  })

  $('.property-box .image-box').mouseleave(function() {
    $(this).find('.owl-nav').addClass('hidden');
  })
});

function createPropertyCarousel(property, carousel) {
  var images = carousel.find('img');
  var loaded_images_count = 0;

  images.error(function() {
    $(this).remove();
    loaded_images_count++;
    if (loaded_images_count == images.length) {
      initializeCarousel(property, carousel);
    }
  });

  images.load(function(){
    loaded_images_count++;
    if (loaded_images_count > 0) {
      initializeCarousel(property, carousel);
    }
  });
}

function initializeCarousel(property, carousel) {
  carousel.owlCarousel({
    nav: true,
    dots: false,
    items: 1,
    lazyLoad: true
  });

  carousel.removeClass('hidden');
  property.find('.loader').addClass('hidden');
  carousel.trigger('refresh.owl.carousel');
}
