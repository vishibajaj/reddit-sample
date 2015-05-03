// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require posts.js


$(document).ready(function(){

	$(".post_vote").on('click', function(event){

		event.preventDefault();
		console.log("Inside Click");
		$(this).removeAttr('href');
		 //$(this).unbind('click');
		$(this).css("background-color","silver");
		if (!($(this).siblings().attr('href'))){

			$(this).siblings().attr("href", "#");
			// $(this).siblings().bind('click');
			$(this).siblings().css("background-color","");
		}
		var pid = $("#post_vote_value_section").data('postid');
		console.log(pid);
		$.ajax({
			url: '/post_vote/value_up',
			type: 'POST',
			data: {post_vote_value: $(this).attr('value'), post_id: pid},
			success: function(response){
				$("#post_vote_value").text(response.post_vote_value);
			},
		});
	});




});


  // $("#post_submit_ajax").click(function(e)
  // {
  //   e.preventDefault();
  //   $.ajax({url: '/user/new_post',
  //     type: 'POST',
  //     data: {title: $("#title").val(), content: $("#content").val()}
  //     }).success(function(response){
  //       $("#new_post").hide();
  //       $('input[type=text]').each(function() { $(this).val(''); });
  //       $('input[type=text_area]').each(function() { $(this).val(''); });
  //       var newPost = "<tr><td>"+response.title+"</td><td>"+response.content+"</td><td><a href=/user/"+response.id+"/edit>EDIT</a></td><td><a href=/user/"+response.id+"/delete>DELETE</a></td></tr>"
  //       $(".gridtable").append(newPost);
  //     });
  // });