$( document ).on('turbolinks:load', ()=>{
  console.log('Payee Input Frame Handler loaded')


  //Slide open Tag Payee Frame
  $('.tagPayee').click((event)=>{
      event.preventDefault();
      var bill_id = (event.currentTarget).getAttribute('billID')
      var item_id = (event.currentTarget).getAttribute('itemID')
      console.log('bill_id = ', bill_id)
      console.log('item_id = ', item_id)
      $(`#tagPayeeItemFrame-${bill_id}`).addClass('tagPayeeItemFrame-show')
      clonePayeeForm(item_id);
        //---Cancel & Close the tag payee frame
        $('.closeTagPayeeItemFrame').click((event)=>{
          event.preventDefault()
          var bill_id = (event.currentTarget).getAttribute('bill-id')
          var item_id = (event.currentTarget).getAttribute('item-id')
          console.log("here>>", event.currentTarget)

          $(`#tagPayeeFrom-${item_id}`).remove()
          $(`#tagPayeeItemFrame-${bill_id}`).removeClass('tagPayeeItemFrame-show')
        });

        //---Starting Template #template_tagPayee_input Clone
          function clonePayeeForm (item_id) {
            var payeeInput = $('#template_tagPayee_input').html().trim()
            var newPayeeInput = $(payeeInput)

            // newPayeeInput.find('div .tagPayeeFrom').removeAttr('id').attr('id',`item-payee-form-${item_id}`)
            newPayeeInput.attr('id',`tagPayeeFrom-${item_id}`)
            newPayeeInput.find('#payee_name').removeAttr('id').attr('id',`payee-name-item${item_id}`)
            newPayeeInput.find('#payee_number').removeAttr('id').attr('id',`payee-number-item${item_id}`)
            newPayeeInput.find('#payee_amount').removeAttr('id').attr('id',`payee-amount-item${item_id}`)
            newPayeeInput.find('#payment_type').attr('id',`payee-payType-item${item_id}`)
            newPayeeInput.find('#addPayeeBtn').removeAttr('id').attr('bill-id',`${bill_id}`).attr('item-id',`${item_id}`)
            newPayeeInput.find('#closeTagPayeeItemFrame').removeAttr('id').attr('bill-id',`${bill_id}`).attr('item-id',`${item_id}`)
            newPayeeInput.appendTo(`.tagPayeeItemContent-${bill_id}`)
          }

      });

  $(document).on('click','.addPayeeBtn',function(event){
      event.preventDefault()
      var point = event.currentTarget;
      var bill_id = (point).getAttribute('bill-id');
      var item_id = (point).getAttribute('item-id')

      var contract = {}
      contract['item_id'] = Number(item_id)
      contract['payee_name'] = $(`#payee-name-item${item_id}`).val();
      contract['payee_no'] = $(`#payee-number-item${item_id}`).val();
      contract['contract_price'] = $(`#payee-amount-item${item_id}`).val();
      contract['payment_type_id'] = $(`#payee-payType-item${item_id}`).val();
      console.log(contract)

      $.post("/contracts", {contract: contract}, function(data){
        console.log('Server Responded')
      })

    });

  //----Add & Close the tag payee frame
  $(document).on('click','.addPayeeBtn',function(event){
      event.preventDefault()
      var point = event.currentTarget
      var bill_id = (point).getAttribute('bill-id')
      var item_id = (point).getAttribute('item-id')
      $(`#tagPayeeFrom-${item_id}`).remove()
      $(`#tagPayeeItemFrame-${bill_id}`).removeClass('tagPayeeItemFrame-show')
    });


}) //END of turbolinks
