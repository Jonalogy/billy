
var event_target;

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

  //---Add Item Ajax
    $('.newItemForm').on('ajax:success', function (event,data) {
      var childCount = ($(`#items_card_list_${data.bill_id}`).children().length) + 1
      $('<div>').text(`${childCount} ${data.item_name}  $${data.item_price}`).appendTo($(`#items_card_list_${data.bill_id}`))
      // newItemAdded()
    })
})

//---Funtions Repo
  function loadAllBills(){
    var billTemplate = $("#billTemplate").html().trim()
    $.getJSON('/dashboard', function(bills_data){
        /*test*/console.log("loadAllBills(AJAX)>>> ",bills_data)
        /*test*/console.log(`${bills_data.length} objects detected`)
      $('#billBook').empty();
      bills_data.forEach(function(bill){
        /*test*/console.log(`Handling:`, bill)
        var newBill = $(billTemplate)

        //---Card
        newBill.find('#template_card').attr('id',`card_${bill.id}`)

        //---View Tab
        newBill.find('#template_viewLink').removeAttr('id').attr('href',`#view_card_${bill.id}`)

        //---View Pane
        newBill.find('#template_viewPane').removeAttr('id').attr('id',`view_card_${bill.id}`)
        newBill.find('#template_billTitle').removeAttr('id').text(bill.title)
        newBill.find('#template_billTotal').removeAttr('id').text('$' + bill.total_price)

        //---Items Tab
        newBill.find('#template_itemsLink').removeAttr('id').attr('href',`#items_card_${bill.id}`)

        //---Items Pane
        newBill.find('#template_itemsPane').removeAttr('id').attr('id',`items_card_${bill.id}`)

        //---Details Tab
        newBill.find('#template_detailsLink').removeAttr('id').attr('href',`#details_card_${bill.id}`)

        //---Details Pane
        newBill.find('#template_detailsPane').removeAttr('id').attr('id',`details_card_${bill.id}`)
        newBill.find('#template_due').removeAttr('id').attr('id',`due_${bill.id}`).text('Due on:' + bill.due)
        newBill.find('#template_details').removeAttr('id').attr('id',`details_${bill.id}`).text(bill.description)

        //---Append
        $('#billBook').append(newBill)
      })// END of bills_data.forEach
      console.log('End of Ajax action')
    })//End of $.getJSON
  }//end of loadAllBills

  // function newItemAdded() {
  //
  //
  //   $.getJSON('/items/show', (newItem)=>{
  //     console.log(' Checking newly added Item ')
  //     console.log(' newItem ')
  //   })
  // }
