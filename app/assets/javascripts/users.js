$(document).ready(function(){
  $("#btn_about").click(function(){
    $(".about_area").toggleClass("hidden");
    if ($(".about_area").attr("class") == "about_area hidden") {
      $('button').text("Edit");
      $('.about_me_content').removeClass("hidden")
    }
    else {
      $('button').text("Close Edit")
      $('.about_me_content').addClass("hidden")
    }
  })
})
