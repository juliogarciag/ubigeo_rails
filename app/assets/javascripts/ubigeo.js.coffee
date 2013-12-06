isNumber = (n) ->
  !isNaN(parseFloat(n)) && isFinite(n)

# Manager
class UbigeoDependantManager
  constructor: ({@el}) ->
    @baseUrl  = @el.data('url')
    @deptEl   = @el.find('.ubigeo_department')
    @provEl   = @el.find('.ubigeo_province')
    @distEl   = @el.find('.ubigeo_district')
    @hiddenEl = @el.find('.ubigeo_hidden')
    
  startListeners: ->
    @deptEl.on 'change', => @loadProvinces()
    @provEl.on 'change', => @loadDistricts()
    
    @allTheBoxes().on 'change', =>
      @updateHiddenUbigeo()
  
  allTheBoxes: ->
    @deptEl.add(@provEl).add(@distEl)
  
  loadDepartments: (cb) ->
    @loadUbigeo @deptEl, @departmentsUrl(), cb
  
  loadProvinces: (cb) ->
    deptVal = @deptEl.val()
    if isNumber(deptVal)
      @loadUbigeo @provEl, @provincesUrl(deptVal), cb
  
  loadDistricts: (cb) ->
    provVal = @provEl.val()
    if isNumber(provVal)
      @loadUbigeo @distEl, @districtsUrl(provVal), cb
  
  cascadeLoad: ->
    # REFACTOR: This is a callback hell D:
    # The pyramid of Doom
    # REFACTOR ME PLEASE!
    # 
    # Ok, let's this refactoring be a homework for the others :)
    # 
    @getLoadedSelection @deptEl, (deptValue) =>
      @provEl.one 'ubigeo:loaded', =>
        @getLoadedSelection @provEl, (provValue) =>
          @distEl.one 'ubigeo:loaded', =>
            @getLoadedSelection @distEl, (distValue) =>
              @distEl.val(deptValue + provValue + distValue).trigger('change')
          @provEl.val(deptValue + provValue).trigger('change')
      @deptEl.val(deptValue).trigger('change')
  
  getLoadedSelection: (box, callback) ->
    sel = box.data('selection')
    callback(sel) if isNumber(sel)
  
  updateHiddenUbigeo: ->
    @hiddenEl.val @ubigeoValue()
  
  ubigeoValue: ->
    @distEl.val() || @provEl.val() || @deptEl.val()
  
  departmentsUrl: -> @baseUrl
  provincesUrl: (id) -> "#{@baseUrl}/#{id}"
  districtsUrl: (id) -> "#{@baseUrl}/#{id}"
  
  loadUbigeo: (element, url, cb) ->
    # erase only the options with value
    element.find("option[value]").remove()
    
    @loadEach
      url: url
      each: ({id, name}) =>
        element.append @buildSelect(id, name)
      after: =>
        element.trigger('ubigeo:loaded')
        element.trigger('change') if isNumber(element.val())
        cb?()
  
  buildSelect: (id, name) ->
    "<option value='#{id}'>#{name}</option>"
  
  loadEach: ({url, each, after}) ->
    $.getJSON(url).success (data) =>
      each(element) for element in data
      after(data)

# Usage
ready = ->
  # should decorate the ubigeo_input class elements
  manager = new UbigeoDependantManager el: $('.ubigeo_input')
  
  # only begins the load if the elements exists
  if manager.el.length > 0
    # set the event listeners
    manager.startListeners()
    # load the departments
    manager.loadDepartments =>
      manager.cascadeLoad()

$(document).ready(ready)
$(document).on('page:load', ready)