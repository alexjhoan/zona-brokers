$(document).ready(function () {
  $('button.load-more').click(function (e) {
    e.preventDefault();
    $('.load-more').addClass('hidden');
    $('.loading-gif').removeClass('hidden');
  });
});
