# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#s3-uploader").S3Uploader
  	remove_completed_progress_bar: false,
  	allow_multiple_files: false

$(document).bind 's3_upload_complete', (e, content) ->
	$("#urlcom").val content.url
	$('#status').text('done');
	$('#fsubmit').removeClass('disabled');
	$('#fsubmit').unbind('click');

	