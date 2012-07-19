function updateCountdown() {
	// 140 is max length;
	var remaining = 140 - $('#micropost_content').val().length;
	$('.countdown').text(remaining + ' characters remaining');
}

$(document).ready(function(){
	updateCountdown()
	$('#micropost_content').change(updateCountdown);
  $('#micropost_content').keyup(updateCountdown);
})