// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/


$( document ).on('turbolinks:load', function() {
  console.log("turbolinks On");
  backgroundMedia()
  $(window).resize(function(){backgroundMedia()})

})

function backgroundMedia(){

  let screenWidth = $(window).width()
  let screenHeight = $(window).height()


  let size = getRandomInt(50, 100)

  // console.log(screenWidth, screenHeight, size)
  var pattern = Trianglify({
  height: screenHeight,
  width: screenWidth,
  x_colors: 'YlOrRd',
  y_colors : 'YlOrRd',
  cell_size: size});
  $('#background').remove()
  document.body.prepend(pattern.canvas());
  $('canvas').attr('id','background')

  function getRandomInt(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min)) + min;
  }
}
