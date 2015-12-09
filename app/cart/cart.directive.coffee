class Cart extends Directive

  constructor: (imagoUtils, imagoCart) ->

    return {

      templateUrl: '/app/cart/cart.html'
      controller: 'imagoCartController as cart'

    }
