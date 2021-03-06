// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery
//= require jquery_ujs
//= require materialize
//= require swiper

import * as RailsUjs from '@rails/ujs'
// require('turbolinks').start()
import * as RailsActiveStorage from '@rails/activestorage'

import '../tweets.js'
import '../swiper.js'
import '../note-body-copy.js'

RailsUjs.start()
RailsActiveStorage.start()

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
