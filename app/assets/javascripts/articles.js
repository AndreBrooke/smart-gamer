// Adapted from http://jsfiddle.net/iambriansreed/bjdSF/
$(document).ready(function() {
  var minimized_elements = $('div.minimize');

  minimized_elements.each(function(){    
    var t = $(this).text();        
    if(t.length < 500) return;
      
    $(this).html(
      t.slice(0,500)+'<span>... </span><a href="#" class="more">More</a>'+
      '<span style="display:none;">'+ t.slice(500,t.length)+' <a href="#" class="less">Less</a></span>'
    );      
  }); 

  $('a.more', minimized_elements).click(function(event){
    event.preventDefault();
    $(this).hide().prev().hide();
    $(this).next().show();        
  });

  $('a.less', minimized_elements).click(function(event){
    event.preventDefault();
    $(this).parent().hide().prev().show().prev().show();    
  });

  // FIXME - not working on ajax loaded content - require delegation
  // $('.comment-wrapper-child').hover(
  //   function() {
  //     $(this).addClass('comment-highlight');
  //   },
  //   function() {
  //     $(this).removeClass('comment-highlight');
  //   }
  // );
})
