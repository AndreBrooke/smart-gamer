$(document).ready(function(){
  $(".btn").click(function(){
    $(".btn").each(function(){
      $(this).removeClass("active")
    })
    $(this).addClass("active")
    var text = $(this).text();
    switch (text) {
      case 'All':
        $(".bootstrap-table").removeClass("hidden")
        $("#articles_search_result").removeClass("hidden")
        break;
      case 'Gamers':
        $(".bootstrap-table").removeClass("hidden")
        $("#articles_search_result").addClass("hidden")
        break;
      case 'Articles':
        $(".bootstrap-table").addClass("hidden")
        $("#articles_search_result").removeClass("hidden")
        break;
    }

  })
})
