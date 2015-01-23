prompt = require 'prompt'
async = require 'async'
ordrin = require 'ordrin-api'

servers = {}

servers.TEST =
  restaurant: "https://foodbot.ordr.in:7000"
  user: "https://foodbot.ordr.in:7000"
  order: "https://foodbot.ordr.in:7000"

servers.PRODUCTION =
  restaurant: "https://foodbot.ordr.in"
  user: "https://foodbot.ordr.in"
  order: "https://foodbot.ordr.in"

ordrinApi = new ordrin.APIs "0000000000000000000", servers.PRODUCTION

createOrdrinAccount = (asyncCb) ->
  prompt.get
    name: 'accountExists'
    description: 'Do you already have an ordr.in account? (y/n)'
    type: 'string'
    required: true,
    (err, result) ->
      if err
        asyncCb err
      if result.accountExists.toUpperCase() is 'N'
        console.log "Please enter the fields to create an account."
        prompt.get ['email', {name:'password', hidden:true}, 'firstName', 'lastName'], (err, result) ->
          if err
            asyncCb err
          ordrinApi.create_account(
            email: result.email
            pw: result.password
            first_name: result.firstName
            last_name: result.lastName,
            (err, data) ->
              if err
                console.log "Sorry there was a problem with the data you entered. Try again."
                console.log err
                return createOrdrinAccount(asyncCb)
              console.log "User #{result.email} created"
              asyncCb(null, result);
          )
      else
        console.log "Please enter your ordr.in account credentials"
        prompt.get ['email', {name: 'password', hidden:true}], (err, result) ->
          if err
            asyncCb err
          ordrinApi.get_account_info(
            email: result.email
            current_password: result.password,
            (err, data) ->
              if err
                console.log "Sorry there was a problem with the data you entered. Try again."
                console.log err
                return createOrdrinAccount(asyncCb)
              console.log "Login succesful"
              asyncCb(null, result)
          )

createOrdrinAddress = (createAccount, asyncCb) ->
  console.log "Please enter the address hungrybot will be delivering to."
  prompt.get ['street address', 'street address 2', 'city', 'state', 'zip', 'phone'], (err, result) ->
    ordrinApi.create_addr(
      email: createAccount.email
      current_password: createAccount.password
      nick: 'groupLocation'
      addr: result['street address']
      addr2: result['street address 2']
      city: result.city
      state: result.state
      zip: result.zip
      phone: result.phone,
      (err, data) ->
        if err
          console.log "Sorry there was a problem with the data you entered. Try again."
          console.log err
          return createOrdrinAddress(createAccount, asyncCb)
        console.log 'Address created'
        asyncCb(null, createAccount, result);
    )

createCC = (createAccount, createAddress, asyncCb) ->
  console.log "Please enter the credit card details that hungrybot will charge."
  prompt.get ['cardNumber', 'cardCvc', 'cardExpirationDate (MM/YYYY)', 'billingAddress', 'billingCity', 'billingState', 'billingZipCode', 'billingPhoneNumber'], (err, result) ->
    ordrinApi.create_cc(
      email: createAccount.email
      current_password: createAccount.password
      nick: 'groupCard'
      card_number: result.cardNumber
      card_cvc: result.cardCvc
      card_expiry: result['cardExpirationDate (MM/YYYY)']
      bill_addr: result.billingAddress
      bill_city: result.billingCity
      bill_state: result.billingState
      bill_zip: result.billingZipCode
      bill_phone: result.billingPhoneNumber,
      (err, data) ->
        if err
          console.log "Sorry there was a problem with the data you entered. Try again."
          console.log err
          return createCC(createAccount, createAddress, asyncCb)
        console.log 'Credit card created'
        asyncCb()
    )

prompt.start()
async.waterfall [createOrdrinAccount, createOrdrinAddress, createCC], (err, result) ->
  if err
    console.log "An error has occured"
    console.log err
    return
  console.log "Be sure to read the documentation to determine which environment variables you need to save."