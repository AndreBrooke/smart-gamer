// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require Chart.bundle
//= require chartkick
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require bootstrap-table
//= require turbolinks
//= require_tree .
function create_notification(remain_time){
  new PNotify({
   title: 'Desktop Notification',
   text: "Remain " + remain_time + " minutes left to play to reach the desired time.",
   desktop: {
      desktop: true,
      icon: null
   }
  });
};

function my_function(){
  $.ajax({
    url: "/user/create_user_notifications",
    dataType: "json",
    type: 'GET',
    success: function(data) {
      console.log(data);
      if (data <= 5){
        new PNotify({
         title: 'Desktop Notification',
         text: "It's time to stop game if you want to reach the desired time.",
         desktop: {
            desktop: true,
            icon: null
         }
        });
      } else if(data <= 10) {
        create_notification(10);
      } else if(data <= 20) {
        create_notification(20);
      } else if(data <= 30) {
        create_notification(30);
      } else if(data <= 40) {
        create_notification(40);
      } else if(data <= 50) {
        create_notification(50);
      } else if(data <= 60) {
        create_notification(60);
      }
    }
  });
};
setInterval(my_function, 600000);
