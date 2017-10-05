$(document).ready(function(){
  $(".btn").click(function(){
    $(".btn").each(function(){
      $(this).removeClass("active")
    })
    $(this).addClass("active")
    var text = $(this).text();
    switch (text) {
      case 'All':
        $("#users_search_result").removeClass("hidden")
        $("#articles_search_result").removeClass("hidden")
        break;
      case 'Gamers':
        $("#users_search_result").removeClass("hidden")
        $("#articles_search_result").addClass("hidden")
        break;
      case 'Articles':
        $("#users_search_result").addClass("hidden")
        $("#articles_search_result").removeClass("hidden")
        break;
    }

  })
})
