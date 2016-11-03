$( document ).on('turbolinks:load', ()=>{
  console.log('Payee Input Frame Handler loaded')

  //Slide open Tag Payee Frame
  $('.tagPayee').click((event)=>{
      event.preventDefault();
      var bill_id = (event.currentTarget).getAttribute('billID')
      var item_id = (event.currentTarget).getAttribute('itemID')
      console.log('bill_id = ', bill_id)
      console.log('item_id = ', item_id)
      $(`#tagPayeeItemFrame-bill${bill_id}`).addClass('tagPayeeItemFrame-show')

      appendCheckMobile()

        /* Clone Template: Mobile Payee Number Input*/
        function appendCheckMobile() {
          var mobileInputTemplate = $('#request_payee_number').html().trim()
          var mobileInput = $(mobileInputTemplate)
          console.log(mobileInput);
          mobileInput.find('.template-inputPayeeNum').attr('id', `inputPayeeNum-item${item_id}`).removeClass('template-inputPayeeNum').attr('bill-id',`${bill_id}`).attr('item-id',`${item_id}`)
          mobileInput.find('.template-checkPayeeNoBtn').attr('id', `checkPayeeNoBtn-item${item_id}`).removeClass('template-checkPayeeNoBtn').attr('bill-id',`${bill_id}`).attr('item-id',`${item_id}`).removeClass('template-checkPayeeNoBtn')
          mobileInput.find('#closeTagPayeeItemFrame').removeAttr('id').attr('bill-id',`${bill_id}`).attr('item-id',`${item_id}`)
          mobileInput.appendTo(`#tagPayeeItemContent-bill${bill_id}`)
        } //END Function appendCheckMobile()

        //---Event Listerner: Search Mobile Number
        $('.checkPayeeNoBtn').click((event)=>{
          var pointer = event.currentTarget
          var bill_id = (event.currentTarget).getAttribute('bill-id')
          var item_id = (event.currentTarget).getAttribute('item-id')
          console.log(`bill_id = ${bill_id}`,`item_id = ${item_id}`)
          var num = $(`#inputPayeeNum-item${item_id}`).val()
          console.log(`Payee Number: ${num}`)
          var number = {payee_contact:num}
          $(`#tagPayeeItemContent-bill${bill_id}`).empty()

          $.get('/check', {number:number} ,(data)=>{
            console.log('Server Responded! ', data)
            if (data === false) { /* Load manual entry */ nonMemberPayee(data,num) }
          });

          function nonMemberPayee(reg_user, recordedPayeeNum){
            $(`#tagPayeeItemContent-bill${bill_id}`).empty()

            /* Append nonMemberPayee-form */
            var nonMemberPayeeInputTemplate = $('#template-nonMemberPayee').html().trim()
            var nonMemberPayee = $(nonMemberPayeeInputTemplate)

            nonMemberPayee.attr('id',`nonMemberPayee-form-item${item_id}`).removeClass('template-nonMemberPayee-form')
            nonMemberPayee.find('.template-payeeNumRecord').attr('id',`payeeNumRecord-item${item_id}`).val(recordedPayeeNum).removeClass('template-payeeNumRecord')
            nonMemberPayee.find('.template-payee_name').attr('id',`payee_name-item${item_id}`).removeClass('template-payee_name')
            nonMemberPayee.find('.template-payType').attr('id',`payType-item${item_id}`).removeClass('template-payType')
            nonMemberPayee.find('.template-payee_amount').attr('id',`payee_amount-item${item_id}`).removeClass('template-payee_amount')
            nonMemberPayee.find('.template-addPayeeBtn').attr('id',`addPayeeBtn-item${item_id}`).attr('bill-id',`${bill_id}`).attr('item-id',`${item_id}`).attr('reg_user',`${reg_user}`).removeClass('template-addPayeeBtn')
            nonMemberPayee.find('.template-closeTagPayeeItemFrame').attr('id',`addPayeeBtn-item${item_id}`).attr('bill-id',`${bill_id}`).attr('item-id',`${item_id}`).removeClass('template-closeTagPayeeItemFrame')

            nonMemberPayee.appendTo(`#tagPayeeItemContent-bill${bill_id}`)
          } //END function nonMemberPayee()

        })// END $('.checkPayeeNoBtn').click
        //clonePayeeForm(item_id);  //---Revamping Tag Payee User Flow
        //---Starting Template #template_tagPayee_input Clone
        //---function clonePayeeForm (item_id) {
          //   var payeeInput = $('#template_tagPayee_input').html().trim()
          //   var newPayeeInput = $(payeeInput)
          //
          //   // newPayeeInput.find('div .tagPayeeFrom').removeAttr('id').attr('id',`item-payee-form-${item_id}`)
          //   newPayeeInput.attr('id',`tagPayeeFrom-${item_id}`)
          //   newPayeeInput.find('#payee_name').removeAttr('id').attr('id',`payee-name-item${item_id}`).attr('item-id',`${item_id}`)
          //   newPayeeInput.find('#payee_number').removeAttr('id').attr('id',`payee-number-item${item_id}`)
          //   newPayeeInput.find('#payee_amount').removeAttr('id').attr('id',`payee-amount-item${item_id}`)
          //   newPayeeInput.find('#payment_type').attr('id',`payee-payType-item${item_id}`)
          //   newPayeeInput.find('#addPayeeBtn').removeAttr('id').attr('bill-id',`${bill_id}`).attr('item-id',`${item_id}`)
          //   newPayeeInput.find('#closeTagPayeeItemFrame').removeAttr('id').attr('bill-id',`${bill_id}`).attr('item-id',`${item_id}`)
          //   newPayeeInput.appendTo(`.tagPayeeItemContent-${bill_id}`)
          // }
      });

      //----Adds and appends new user---
        //Note: .addPayeeBtn has been changed to .checkPayeeNoBtn
      $(document).on('click','.addPayeeBtn',function(event){
          event.preventDefault()
          var point = event.currentTarget;   console.log(point)
          var bill_id = (point).getAttribute('bill-id');
          var item_id = (point).getAttribute('item-id');
          var reg_user = (point).getAttribute('reg_user');

          var payee_name = $(`#payee-name-item${item_id}`).val();

          var contract = {}
          contract['item_id'] = Number(item_id)
          contract['reg_user'] = reg_user
          contract['payee_name'] = $(`#payee_name-item${item_id}`).val();
          contract['payee_contact'] = $(`#payeeNumRecord-item${item_id}`).val();
          contract['contract_price'] = $(`#payee_amount-item${item_id}`).val();
          contract['payment_type_id'] = $(`#payType-item${item_id}`).val();
          // contract = JSON.stringify(contract)
          console.log(contract)

          $.post("/contracts", {contract_noreg: contract}, function(data){
            console.log('Server Responded')
            console.log($(`#tagPayee-input-holder-${bill_id}`));
            $(`#tagPayee-input-holder-${bill_id}`).prepend($('<span>').text(`${payee_name}`))
          })
          $(`#tagPayeeItemContent-bill${bill_id}`).empty()
        });


  //---Cancel & Close the tag payee frame
  $(document).on('click','.closeTagPayeeItemFrame',function(event){
    event.preventDefault()
    var bill_id = (event.currentTarget).getAttribute('bill-id')
    var item_id = (event.currentTarget).getAttribute('item-id')
    console.log("here>>", event.currentTarget)

    $(`#tagPayeeItemContent-bill${bill_id}`).empty()
    $(`#tagPayeeItemFrame-bill${bill_id}`).removeClass('tagPayeeItemFrame-show')
    // $(`#tagPayeeFrom-${item_id}`).remove()
  });



  //----Close & resets the tag payee frame
    //Note: .addPayeeBtn has been changed to .checkPayeeNoBtn
  $(document).on('click','.addPayeeBtn',function(event){
      event.preventDefault()
      var point = event.currentTarget
      var bill_id = (point).getAttribute('bill-id')
      var item_id = (point).getAttribute('item-id')
      $(`#tagPayeeFrom-${item_id}`).remove()
      $(`#tagPayeeItemFrame-bill${bill_id}`).removeClass('tagPayeeItemFrame-show')
    });

  // $(document).on('keydown','.payee_name',(event)=>{
  //   var itemID = event.currentTarget.getAttribute('item-id')
  //   var userInput = $(`#payee-name-item${itemID}`).val()
  //   console.log(userInput)
  //   var n = (userInput.length)-1
  //
  //   $.get('/users',function(data){
  //     console.log('Server responded')
  //     console.log(data, typeof data)
  //     data.forEach((el)=>{
  //       if ( userInput == (el.name).substr(0,n) ){
  //         console.log('match!')
  //         // $(`#payee-name-item${itemID}`)
  //       }
  //     })//END data.forEach()
  //   })
  //
  //
  // })

}) //END of turbolinks
