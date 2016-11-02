$( document ).on('turbolinks:load', ()=>{
  console.log('Payee Input Frame Handler loaded')

  console.log($('.tagPayeeItemFrame').width())

//Slide open Tag Payee Frame
  $('.tagPayee').click((event)=>{
    event.preventDefault();
    var bill_id = (event.currentTarget).getAttribute('billID')
    var item_id = (event.currentTarget).getAttribute('itemID')
    console.log('bill_id = ', bill_id)
    console.log('item_id = ', item_id)
    $(`#tagPayeeItemFrame-${bill_id}`).addClass('tagPayeeItemFrame-show')
    clonePayeeForm(item_id);

    //----Add & Close the tag payee frame
    $('.addPayeeBtn').on('click',function (event) {
      event.preventDefault()
      var point = event.currentTarget
      var bill_id = (point).getAttribute('bill-id')
      var item_id = (point).getAttribute('item-id')
      $(`#tagPayeeFrom-${item_id}`).remove()
      $(`#tagPayeeItemFrame-${bill_id}`).removeClass('tagPayeeItemFrame-show')
    });
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
        newPayeeInput.find('#payee_name').removeAttr('id').attr('id',`payee-name-${item_id}`)
        newPayeeInput.find('#payee_number').removeAttr('id').attr('id',`payee-number-${item_id}`)
        newPayeeInput.find('#payee_amount').removeAttr('id').attr('id',`payee-amount-${item_id}`)
        newPayeeInput.find('#payee_amount').removeAttr('id').attr('id',`payee-amount-${item_id}`)
        newPayeeInput.find('#payment_type').attr('id',`payment_type_for_item-${item_id}`)
        newPayeeInput.find('#addPayeeBtn').removeAttr('id').attr('bill-id',`${bill_id}`).attr('item-id',`${item_id}`)
        newPayeeInput.find('#closeTagPayeeItemFrame').removeAttr('id').attr('bill-id',`${bill_id}`).attr('item-id',`${item_id}`)
        newPayeeInput.appendTo(`.tagPayeeItemContent-${bill_id}`)
      }

  });

})
