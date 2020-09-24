'use strict'

BaseService = require 'scripts/BaseClasses/BaseService.coffee'

###
  @name:
  @type: service
  @desc: Implementation of the Beta distribution model

###

module.exports = class BetaDist extends BaseService
  @inject 'app_analysis_modeler_getParams'
  initialize: () ->
    @calc = @app_analysis_modeler_getParams
    @Alpha = 1
    @Beta = 1
    @name = 'Beta'


  getName: () ->
    return @name

  getBetaDistribution: (leftBound, rightBound) ->
    data = []
    for i in [leftBound...rightBound] by .1
      data.push
        x: i
        y: @PDF(i)
    data

  factorial: (x) ->
    t = 1
    while x > 1
      t *= x--
    t

  gammaFn: (x) ->
    return @factorial(x-1)

  getChartData: (params) ->
    curveData = @getBetaDistribution(params.xMin , params.xMax)
    return curveData

  PDF: (x) ->
    B = @gammaFn(@Alpha) * @gammaFn(@Beta) / @gammaFn(@Alpha + @Beta)
    return Math.pow(x, @Alpha - 1) * Math.pow(1 - x, @Alpha - 1) / B

  getParams: () ->
    console.log("In beta getparams")
    console.log("@Alpha: ", @Alpha, " @Beta: ", @Beta)
    params =
      alpha: @Alpha
      beta: @Beta

  setParams: (newParams) ->
    console.log("In beta setparams")
    console.log("@Alpha before: ", @Alpha, " @Beta before: ", @Beta)
    @Alpha = newParams.stats.alpha
    @Beta = newParams.stats.beta
    console.log("@Alpha after: ", @Alpha, " @Beta after: ", @Beta)