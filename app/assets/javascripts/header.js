$( document ).on('ready', function() {
  var show_collapsable_menu = false;

  $('#menu-button').on('click', function() {
    if (show_collapsable_menu) {
      $('#collapsable-menu').removeClass('visible-sm visible-xs');
      show_collapsable_menu = false;
    } else {
      $('#collapsable-menu').addClass('visible-sm visible-xs');
      show_collapsable_menu = true;
    }
  })
});
