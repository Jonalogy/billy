
$( document ).on('turbolinks:load', function() {
  console.log("Dashboard.js Loaded");

  //---Ajax Repo---
    $('#addBill').on('ajax:success', function () {
      loadAllBills()
    })
    $('#addBill').on('ajax:beforeSend', function () {
      $('#newBillWindow').collapse('hide')
      $('#addBill')[0].reset();
    })

})

//---Funtions Repo
  function loadAllBills(){
    var billTemplate = $("#billTemplate").html().trim()
    $.getJSON('/dashboard', function(data){
      console.log("loadAllBills(AJAX)>>> ",data)
      console.log(`${data.length} objects detected`)
      $('#billBook').empty();
      data.forEach(function(ele){
        console.log(`Handling:`, ele)
        var newBill = $(billTemplate)
        newBill.children('.billTitle').text(ele.title)
        newBill.children('.billTotal').text('$' + ele.total_price)
        newBill.children('.billDueDate').text(ele.due_date)
        if(ele.clear == false){ var status = 'On going' }
        else { var status = 'Cleared' }
        newBill.children('.billStatus').text('Status: ' + status)
        $('#billBook').append(newBill)
      })// END of data.forEach
      console.log('End of Ajax action')
    })//End of $.getJSON
  }//end of loadAllBills
