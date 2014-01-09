jQuery ->
  $("#s3-uploader-form-comment").S3Uploader
  	remove_completed_progress_bar: false,
  	allow_multiple_files: false


$(document).bind 's3_upload_complete', (e, content) ->
	$("#url").val content.url
	$("#urlcom").val content.url
	$("#urlreq").val content.url

jQuery ->
  $("#s3-uploader-form-commentp").S3Uploader
  	remove_completed_progress_bar: false,
  	allow_multiple_files: false


$(document).bind 's3_upload_complete', (e, content) ->
	$("#url").val content.url
	$("#urlcom").val content.url
	$("#urlreq").val content.url