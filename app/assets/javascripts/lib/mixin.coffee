# Backbone & Marionette Mixin Module
# https://coderwall.com/p/m0w3dw/coffeescript-mixins-in-backbone
include = (mixins...) ->
    throw new Error('include(mixins...) requires at least one mixin') unless mixins and mixins.length > 0

    for mixin in mixins
      for key, value of mixin
        @::[key] = value unless key is 'included'

      mixin.included?.apply(this)
    this

Backbone.Model.include = Backbone.Collection.include = include
Backbone.View.include = Backbone.Router.include = include
Marionette.ItemView.include = include
Marionette.LayoutView.include = include
