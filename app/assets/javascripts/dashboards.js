
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

  //---Add Item Ajax---
    $('.newItemForm').on('ajax:success', function (event,data) {
      var body = $('<div>', {class:'bill_item'})
      //Item Info
        var itemBlock = $('<div>', {class:'col-sm-9'})
        $('<div>').text(data.item_name).appendTo(itemBlock)
        $('<div>').text('$'+data.item_price).appendTo(itemBlock)
        itemBlock.appendTo(body)
      // //Payee Tags
        var payeeBlock = $('<div>',{class:'col-sm-3'})
        var tagLink = $('<a>' , {href:"#", class: "btn btn-outline-info btn-sm", role:"button" })
        /*icon*/ $('<i>' , { class:"fa fa-user-plus" }).attr('aria-hidden','true').appendTo(tagLink)
        tagLink.appendTo(payeeBlock)
        payeeBlock.appendTo(body)

        body.prependTo($(`#items_card_list_${data.bill_id}`))
    })//END ajax:success
    $('.submit_item').click((event)=>{
      var event_id  = event.target.id;
      var n = (event_id.length)-1;
      var id = event_id.substr(n,n);
      console.log('id>>>',id)
      $(`#addItemCollapse_${id}`).collapse('hide')
    })

  //---Tag Payee---
    $('.tagPayee').click((event)=>{
      event.preventDefault();
      var n = (event.currentTarget.id).length - 1;
      var bill_id_clicked = (event.currentTarget.id).substr(n,n)
      console.log('bill_id_clicked >>>', (bill_id_clicked))

      $(`#tagPayee-${bill_id_clicked}`).remove()

      //---Starting Template #template_tagPayee_input Clone
        var payeeInput = $('#template_tagPayee_input').html().trim()
        var newPayeeInput = $(payeeInput)

        newPayeeInput.appendTo($(`#tagPayee-input-holder-${bill_id_clicked}`))
    });


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
