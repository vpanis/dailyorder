// Date picker
$(function() {
  $('.calendar').datepicker({
    format: "dd/mm/yyyy",
    weekStart: 1,
    startDate: "+1d",
    daysOfWeekDisabled: [0],
    todayHighlight: true,
    multidate: false,
    language: 'fr',
  });

  $('.calendar').datepicker({useCurrent: false});
  $('.calendar').datepicker();
  $('.calendar').on('changeDate', function() {
    $('.datepicker_hidden_field').val(
      $('.calendar').datepicker('getFormattedDate')
    );
  });
});
