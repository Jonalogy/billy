$( document ).on('turbolinks:load', ()=>{
  console.log('Payee Input Frame Handler loaded')

  console.log($('.tagPayeeItemFrame').width())

  $('.tagPayee').click((event)=>{
    event.preventDefault();
    var bill_id = (event.currentTarget).getAttribute('billID')
    console.log(bill_id)
    $(`#tagPayeeItemFrame-${bill_id}`).addClass('tagPayeeItemFrame-show')
  });

  $('.closeTagPayeeItemFrame').click((event)=>{
  var bill_id = (event.currentTarget).getAttribute('billID')
    $(`#tagPayeeItemFrame-${bill_id}`).removeClass('tagPayeeItemFrame-show')
  });



})


// tagPayeeFrame
// tagPayeeFrame-show
