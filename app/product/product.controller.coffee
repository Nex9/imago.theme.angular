class ProductController extends Controller

  constructor: (@$state, $rootScope, @$scope, @imagoProduct, @promiseData, @imagoCart) ->


    if @imagoCart.currency
      return @getProduct()

    watcher = $rootScope.$on 'imagocart:currencyloaded', (evt, data) =>
      @getProduct()
      watcher()

  getProduct: ->
    @optionsWhitelist = [
      {
        'name'  : '{{fieldName}}'
        'color' : '{{fieldColor}}'
      }
    ]

    optionsProduct =
      optionsWhitelist : @optionsWhitelist
      lowStock  : 3

    # set variant form url
    for item in @optionsWhitelist
      continue unless @$state.params[item.name]
      optionsProduct[item.name] = @$state.params[item.name]

    # setup data
    for item in @promiseData
      @data = item
      @productItem = new @imagoProduct(item.variants, optionsProduct)
      break

    # watch product options
    toWatchProperties = []
    createWatchFunc = (name) =>
      toWatchProperties.push(=> @productItem[name])

    for item in @optionsWhitelist
      continue unless item.name
      createWatchFunc(item.name)

    @$scope.$watchGroup toWatchProperties, (value) =>
      @changePath()

  changePath: ->
    parameters = {}
    for item in @optionsWhitelist
      parameters[item.name] = @productItem[item.name]
      changed = true if @productItem[item.name] isnt @$state.params[item.name]

    return unless changed


    # change url
    @$state.go 'product', parameters,
      location: 'replace'
      notify: false

    # set selected variant
    for item in @optionsWhitelist
      @productItem.setOption item.name, parameters[item.name]


