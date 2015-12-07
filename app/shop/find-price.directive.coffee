class FindPrice extends Directive

  constructor: ->

    return {

      scope: true
      controller: 'findPriceController as findprice'
      bindToController:
        options: '=variants'
        product: '='
      templateUrl: '/app/shop/find-price.html'

    }

class FindPriceController extends Controller

  constructor: ($scope, @imagoCart) ->

    calculate = =>
      return unless @imagoCart.currency and @options?.length and $scope.findprice.product
      @variants = _.clone @options

      if $scope.findprice.product.lensTechnology or $scope.findprice.product.frameColor
        @variants = _.filter @variants, (item) =>
          if $scope.findprice.product.lensTechnology and $scope.findprice.product.frameColor
            return $scope.findprice.product.lensTechnology is item.fields?.lensTechnology?.value and $scope.findprice.product.frameColor is item.fields?.frameColor?.value
          else if $scope.findprice.product.frameColor
            return $scope.findprice.product.frameColor is item.fields?.frameColor?.value
          else if $scope.findprice.product.lensTechnology
            return $scope.findprice.product.lensTechnology is item.fields?.lensTechnology?.value

      @findPrice()

    $scope.$watchGroup ['findprice.imagoCart.currency', 'findprice.options', 'findprice.product.frameColor', 'findprice.product.lensTechnology'], =>
      calculate()

  findPrice: ->
    @prices = []
    @discounts = []

    for option in @variants
      if option.fields?.price?.value?[@imagoCart.currency]
        @prices.push option.fields.price.value[@imagoCart.currency]

      if option.fields?.discountedPrice?.value?[@imagoCart.currency]
        @discounts.push option.fields.discountedPrice.value[@imagoCart.currency]

    return unless @prices.length
    @highest = Math.max.apply(Math, @prices)

    if @discounts.length
      @lowest = Math.max.apply(Math, @discounts)
    else
      @lowest = Math.min.apply(Math, @prices)

    # console.log '@prices', @prices
    # console.log '@highest', @highest
    # console.log '@lowest', @lowest

