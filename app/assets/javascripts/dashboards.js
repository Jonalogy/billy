$( document ).on('turbolinks:load', function() {
    console.log("Dashboard.js Loaded");

  loadAllPayables() // As of now, this function only loads all bills.




  //---Ajax: After user added a new bill---
    $('#addBill').on('ajax:success', function () {
      loadAllBills()
    })
    $('#addBill').on('ajax:beforeSend', function () {
      $('#newBillWindow').collapse('hide')
      $('#addBill')[0].reset();
    })

  //---Add Item Ajax---
    $('.newItemForm').on('ajax:success', function (event,data) {
      console.log("server responded")
      console.log(data)
      var body = $('<div>', {id:'bill_item' + data.id, class:'bill_item'})
      //Item Info
        var itemBlock = $('<div>', {class:'col-sm-7'})
        $('<div>').text(data.item_name).appendTo(itemBlock)
        $('<div>').text('$'+data.item_price).appendTo(itemBlock)
        itemBlock.appendTo(body)
      //Delete Item
        var delBtn = $('<div>',{class:'col-sm-1'})
        var delLink = $('<a>' , {href:"#", class: "delItem-btn btn btn-outline-danger btn-sm", role:"button", billid: data.bill_id, itemid: data.id})
        /*icon*/ $('<i>' , { class:"fa fa-trash" }).attr('aria-hidden','true').appendTo(delLink)

        delLink.appendTo(delBtn)
        delBtn.appendTo(body)


      //View Payee
        var payeeCount = $('<div>',{class:'col-sm-1'})
        var payeeCountLink = $('<a>' , {id: 'payeeInfo-btn' + data.id, class: "payeeInfo-btn btn btn-outline-info btn-sm", role:"button", billid: data.bill_id, itemid:data.id })
        $('<span>',{id:'payee_count-item' + data.id}).appendTo(payeeCountLink)
        /*icon*/ $('<i>' , { class:"fa fa-user" }).attr('aria-hidden','true').appendTo(payeeCountLink)
        payeeCountLink.appendTo(payeeCount)
        payeeCount.appendTo(body)

      //Tag Payee
        var payeeBlock = $('<div>',{class:'col-sm-1'})
        var tagLink = $('<a>' , {id:'tagPayeeItem-' + data.id, class: "btn btn-outline-success btn-sm tagPayee", role:"button", billid: data.bill_id, itemid:data.id})
        /*icon*/ $('<i>' , { class:"fa fa-user-plus" }).attr('aria-hidden','true').appendTo(tagLink)
        tagLink.appendTo(payeeBlock)
        payeeBlock.appendTo(body)
        body.insertBefore('#tagPayeeItemFrame-bill' + data.bill_id)
    })//END ajax:success



  //--- !!!!!!!!Unfinished!!!!!!!
    $(document).on('click','.payeeInfo-btn',function(event){
      event.preventDefault()
      var point  = event.currentTarget;
      var bill_id = point.getAttribute("billid")
      var item_id = point.getAttribute("itemid")
      console.log(point)
      console.log('Trigger pane: ', bill_id)
      $( '#tagPayeeItemFrame-bill' + bill_id).toggleClass('tagPayeeItemFrame-show')
    })

//----Event Listeners
    //---Clicking submit closes the tagPayee plane
    $(document).on('click','.submit_item',function(event){
      var point  = event.currentTarget;
      var id = point.getAttribute("billid")
      console.log('id>>>',id)
      $('#addItemCollapse_' + id).collapse('hide')
    })
    //---Delete Bill button---
    $(document).on('click','.bill-delete-btn',function(event){
      event.preventDefault();
      var point = event.currentTarget;
      console.log(point)
      var bill_id = point.getAttribute("bill-id");
      console.log(bill_id)
      //
      $.ajax({
          url: '/bills/' + bill_id,
          type: 'DELETE',
          success: function(data) {
            console.log('server responded')
            console.log(data)
            $('#card_' + data.id).remove()
          }
      });

    });
    //---Delete Item Button---
    $(document).on('click','.delItem-btn',function(event){
      event.preventDefault()
      var point = event.currentTarget;
      var item_id = point.getAttribute('itemid');
      $.ajax({ url:'/items/' + item_id, type: 'DELETE', success: function(data) {
            console.log('server responded')
            console.log(data)
            $( '#bill_item' + item_id).remove()
          } // END  success: function(data)
        }) //END  $.ajax
    })
    //---Pay Button---
    $(document).on('click','.pay-btn',function(event){
      event.preventDefault()
      var point  = event.currentTarget;
      var bill_id = point.getAttribute("billid")
      var item_id = point.getAttribute("itemid")
      console.log(point, bill_id, item_id)

    })

}) //END of Turbolinks

//---Funtions Repo
  function loadAllPayables(){
    $.get('/payables',function(data){
      console.log("Server Responded")
      console.log(data, data.length);

      data.forEach(function(card){
        var payablesTemplate = $('#template-card-payable').html().trim()
        var payableCard = $(payablesTemplate)
        payableCard.find('.template-billTitle').removeClass('.template-billTitle').text(card['bill']['title'])
        payableCard.find('.card-block').removeClass('.card-block').attr('id', "card-block_bill" + card['bill']['id'] )
        payableCard.appendTo('#billBook')

        card['items'].forEach(function(item){
          var itemsTemplate = $('#template-payabale-item-row').html().trim()
          var itemsRow = $(itemsTemplate)
          itemsRow.find('.item_name').text(item["item_name"])
          itemsRow.find('.template-pay-btn').attr('billid',card['bill']['id']).attr('itemid',item['id']).removeClass("template-pay-btn").addClass("pay-btn")

          var payment_type = item["contract_payType"];
          if( payment_type === "Favour"){
            itemsRow.find('.fa').addClass("fa-handshake-o")
            itemsRow.find('.settlement').text( "Return a " + item["contract_payType"] + ": " + item["favour_description"] )

          } else {
            itemsRow.find('.settlement').text("Pay by " + item["contract_payType"] + ": " + "$" + item["contract_price"] + "/ $" + item["item_price"]  )
            itemsRow.find('.fa').addClass("fa-usd")
          }
          itemsRow.appendTo('#card-block_bill' + card['bill']['id'])
        }) //END card['items'].forEach
      }) //END data.forEach(function(card)
    }) //END $.get('/payables',function(data)
  }

  function loadAllBills(){
    var billTemplate = $("#billTemplate").html().trim()
    $.getJSON('/dashboard', function(bills_data){
        /*test*/console.log("loadAllBills(AJAX)>>> ",bills_data)
        /*test*/console.log(bills_data.length + 'objects detected')
      $('#billBook').empty();
      bills_data.forEach(function(bill){
        // /*test*/console.log('Handling:', bill)
        var newBill = $(billTemplate)

        //---Card
        newBill.find('#template_card').attr('id', 'card_' + bill.id)

        //---View Tab
        newBill.find('#template_viewLink').removeAttr('id').attr('href', '#view_card_' + bill.id)

        //---View Pane
        newBill.find('#template_viewPane').removeAttr('id').attr('id', 'view_card_' + bill.id)
        newBill.find('#template_billTitle').removeAttr('id').text(bill.title)
        newBill.find('#template_billTotal').removeAttr('id').text('$' + bill.total_price)

        //---Items Tab
        newBill.find('#template_itemsLink').removeAttr('id').attr('href', '#items_card_' + bill.id)

        //---Items Pane
        newBill.find('#template_itemsPane').removeAttr('id').attr('id', 'items_card_' + bill.id)

        //---Details Tab
        newBill.find('#template_detailsLink').removeAttr('id').attr('href', '#details_card_' +  bill.id)

        //---Details Pane
        newBill.find('#template_detailsPane').removeAttr('id').attr('id', 'details_card_' + bill.id)
        newBill.find('#template_since').removeAttr('id').attr('id', "since_" + bill.id).text('Due on:' + bill.since)
        newBill.find('#template_details').removeAttr('id').attr('id', 'details_' + bill.id).text(bill.description)

        //---Append
        $('#billBook').append(newBill)
      })// END of bills_data.forEach
      console.log('End of Ajax action')
    })//End of $.getJSON
  }//end of loadAllBills
