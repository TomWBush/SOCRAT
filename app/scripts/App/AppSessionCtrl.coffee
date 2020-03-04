'use strict'

BaseCtrl = require 'scripts/BaseClasses/BaseController.coffee'

appControllers = angular.module 'app_controllers'

module.exports = class AppSessionCtrl extends BaseCtrl
  @register appControllers
  @inject '$scope', 'appSidebarState'

  initialize: ->
    @pages = 
        "001": "getData"
        "002": "dataWrangler"
        "003": "charts"
        "004": "tools/dimred/tsne2d"
        "005": "tools/dimred/embedproj"
        "006": "tools/cluster"
        "007": "tools/classification"
        "008": "tools/reliability"
        "009": "tools/modeler"
        "010": "tools/PowerCalc"
        "011": "tools/stats"


  onSessionSubmit: ->
    input_val = $('#sessionId').val()
    if @pages[input_val] != undefined
        current_location = window.location.href
        current_location = current_location.split("#")[0] + "#/" + @pages[input_val]
        window.location.replace(current_location)
    else
        $('#errmsg').html("Invalid session ID").show().fadeOut("slow")

  generateID: ->
    current_location = window.location.href.split("#/")[1]
    for id of @pages
        if @pages[id] == current_location
            alert(id)
            return
    alert("Unable to generate ID for current page.")
   
