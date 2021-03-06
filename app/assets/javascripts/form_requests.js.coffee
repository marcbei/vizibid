# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#s3-uploader-req").S3Uploader
  	remove_completed_progress_bar: false,
  	allow_multiple_files: false


$(document).bind 's3_upload_complete', (e, content) ->
	$("#urlreq").val content.url
	$('#statusr').text('done');
	$('#rsubmit').removeClass('disabled');
	$('#rsubmit').unbind('click');