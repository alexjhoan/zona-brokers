$( document ).on('ready', function() {
  // Continue with last search
  if (!is_mobile && localStorage.getItem('last_search')) {
    $('.home-banner .continue-search').removeClass('hidden');
    $('.home-banner .continue-search').attr('href', localStorage.getItem('last_search'));
  };

  if($('section.properties-search-section').length > 0) {
    localStorage.setItem("last_search", window.location.href);
  }

  $('.home-banner .search-by-reference').on('click', function() {
    var reference_search = $('.home-banner .reference-search');
    var continue_search = $('.home-banner .continue-search-container');

    if(reference_search.hasClass('hidden')) {
      reference_search.removeClass('hidden');
      reference_search.find("input[type='text'].reference-search-input").val('');
      reference_search.find("input[type='text'].reference-search-input").focus();
    } else {
      reference_search.addClass('hidden');
    }
  });

  $('#zone_id').on('change', function() {
    var select_container = $('#property_location_column .multiselect-container');
    var hide_classes = 'multiselect-filter-hidden hidden';
    select_container.children('li').removeClass(hide_classes);

    var selected_option = $('#zone_id option:selected');
    var selected_value = selected_option.text();

    if (selected_value.indexOf('(Departamento)') === -1) {
      var state = selected_option.text().substr(0, selected_value.indexOf('-') - 1);
    } else {
      var state = selected_option.text().substr(0, selected_value.indexOf('(Departamento)') - 1);
    }

    $('#state_id option').each(function() {
      if ($(this).html() == state) {
        $('#state_id').val($(this).val());
      }
    });

    if (select_container.children('li.active').length) {
      if (selected_option.text().indexOf('Departamento') !== -1) {
        select_container.children('li:not(.multiselect-filter, .active)').addClass(hide_classes);
      } else {
        select_container.children('li:not(.multiselect-filter)').each(function() {
          var option_value = $(this).find('a label').text();
          if (option_value.indexOf(state) !== 1 || option_value.indexOf('Departamento') !== -1) {
            $(this).addClass(hide_classes);
          }
        });
      }
    }
  });

  $('.banner-form-box .caret').addClass('hidden');
  $('#operation_type_column .multiselect').append("<i class='icon-down-open'></i>");
  $('#property_type_column .multiselect').append("<i class='icon-down-open'></i>");
  $('#property_location_column .multiselect').append("<i class='icon-plus-circled'></i>");
});

