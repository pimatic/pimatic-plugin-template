# #Plugin pimatic-solvisremote

module.exports = (env) ->

  Promise = env.require 'bluebird'
  assert = env.require 'cassert'
  request = require 'request'
  types = env.require('decl-api').types

  class SolvisRemote extends env.plugins.Plugin
    init: (app, @framework, @config) =>
      deviceConfigDef = require("./device-config-schema")
      @framework.deviceManager.registerDeviceClass("SolvisRemotedevice", {
        configDef: deviceConfigDef.SolvisRemotedevice,
        createCallback: (config) => new SolvisRemotedevice(config)
      })

  class SolvisRemotedevice extends env.devices.Device
    constructor: (@config, @plugin) ->
      @id = @config.id
      @name = @config.name
      @ip = @config.ip
      @user = @config.user
      @pass = @config.pass
      @interval = 1000 * @config.interval
      
      # Attribute/Get Temperaturfühler S1 - S15
      for i in [1...16]
        if @config['s' + i]?
          @addAttribute('s' + i, {
            description: "S" + i,
            label: @config['s' + i].label
            acronym: "S" + i
            type: types.number
            unit: " °C"
          })
          @['getS' + i] = () => Promise.resolve(@['s' + i])
 
      # Attribute/Get Druchfluss l/h S17
      if @config.s17?
        @addAttribute('s17', {
          description: "S17",
          label: @config.s17.label
          acronym: "S17"
          type: types.number
          unit: " l/h"
        })
        @getS17 = () => Promise.resolve(@s17)

      # Attribute/Get Druchfluss l/m S18
      if @config.s18?
        @addAttribute('s18', {
          description: "S18",
          label: @config.s18.label
          acronym: "S18"
          type: types.number
          unit: " l/m"
        })
        @getS18 = () => Promise.resolve(@s18)

      # Attribute/Get Raumfühler R1 - R3
      for i in [1...3]
        if @config['rf' + i]?
          @addAttribute('r' + i, {
            description: "RF" + i,
            label: @config['rf' + i].label
            acronym: "RF" + i
            type: types.number
            unit: " °C"
          })
          @['getRf' + i] = () => Promise.resolve(@['rf' + i])

      # Attribute/Get Ausgänge A1 - A14 + Status
      for i in [1...14]
        if @config['a' + i]?
          @addAttribute('a' + i, {
            description: "A" + i,
            label: @config['a' + i].label
            acronym: "A" + i
            type: types.number
            unit: " °C"
          })
          @['getA' + i] = () => Promise.resolve(@['a' + i])
        if @config['a' + i + '_state']?
          @addAttribute('a' + i + '_state', {
            description: "A" + i + '_state',
            label: @config['a' + i + '_state'].label
            acronym: "A" + i
            type: "boolean"
          })
          @['getA' + i + '_state'] = () => Promise.resolve(@['a' + i + '_state'])


      # Attribute/Get Solarertrag SE
      if @config.se?
        @addAttribute('se', {
          description: "SE",
          label: @config.se.label
          acronym: "SE"
          type: types.number
          unit: " kWh"
        })
        @getSe = () => Promise.resolve(@se)

      # Attribute/Get Solarleistung SL
      if @config.sl?
        @addAttribute('sl', {
          description: "SL",
          label: @config.sl.label
          acronym: "SL"
          type: types.number
          unit: " kW"
        })
        @getSl = () => Promise.resolve(@sl)
 
      super()

      if !@deviceConfigurationError
        @_scheduleUpdate()

    # poll data
    _scheduleUpdate: () ->
      if typeof @intervalObject isnt 'undefined'
        clearInterval(@intervalObject)

      # update
      if @interval > 0
        @intervalObject = setInterval(=>
          @_requestData()
        , @interval
        )

      # update now
      @_requestData()

    destroy: () ->
      super()

    _fetchData:  (url, callback) ->
      opts =
        auth:
          username: @user
          password: @pass
          sendImmediately: false
        json: true
      # request with digest-authentication
      request url, opts, (err, res, body) ->
        if(!err)
          try
            # cut string
            string = body.slice(37)
          catch e
            env.logger.error("requestData: Error fetching data")
            return false
          callback(string)
        else
          env.logger.error(err)

    _requestData: () =>
      @_fetchData "http://" + @ip + "/sc2_val.xml", (string) =>
        # parse string and decode
        for i in [1...64]
          # Temps
          if i < 17
            value = hex2dec(string,4)
            string = string.substr(4)
            if @config['s' + i]?
              if value > 32767
                value = value - 65536;
              value = (value/10)
              @['s' + i] = value
              @emit "s" + i, value
              env.logger.debug("s" + i + ": " + value + " °C")

          # Durchfluss l/m
          if i == 17
            value = hex2dec(string,4)
            string = string.substr(4)
            if @config.s18?
              @s18 = (value/10)
              @emit "s18", (value/10)
              env.logger.debug("s18: " + (value/10) + " l/m")

          # Durchfluss l/h
          if i == 18
            value = hex2dec(string,4)
            string = string.substr(4)
            if @config.s17?
              @s17 = value
              @emit "s17", value
              env.logger.debug("s17: " + value + " l/h")

          # AnalogIn
          if i >= 19 && i <= 21
            value = hex2dec(string,4)
            string = string.substr(4)
            if @config['a_in' + (i - 18)]?
              @['a_in' + (i - 18)] = value
              @emit "a_in" + (i - 18), value
              env.logger.debug("a_in" + (i - 18) + ": " + value)

          # AnalogOut
          if i >= 22 && i <= 25
            value = hex2dec(string,2)
            string = string.substr(2)
            if @config['a_out' + (i - 21)]?
              @['a_out' + (i - 21)] = value
              @emit "a_out" + (i - 21), value
              env.logger.debug("a_out" + (i - 21) + ": " + value)

          # Raumfühler
          if i >= 26 && i <= 28
            value = hex2dec(string,4)
            string = string.substr(4)
            if @config['rf' + (i - 25)]?
              if value > 32767
                value = value - 65536;
              value = (value/10)
              @['r' + (i - 25)] = value
              @emit "r" + (i - 25), value
              env.logger.debug("rf" + (i - 25) + ": " + value + " °C")

          # Outputs
          if i >= 29 && i <= 42
            value = hex2dec(string,2)
            string = string.substr(2)
            if @config['a' + (i - 28)]?
              @['a' + (i - 28)] = value
              @emit "a" + (i - 28), value
              env.logger.debug("a" + (i - 28) + ": " + value)
            if @config['a' + (i - 28) + '_state']?
              if value > 0
                @['a' + (i - 28) + '_state'] = true
                @emit "a" + (i - 28) + "_state", true
                env.logger.debug("a" + (i - 28) + "_state: true")
              else
                @['a' + (i - 28) + '_state'] = false
                @emit "a" + (i - 28) + "_state", false
                env.logger.debug("a" + (i - 28) + "_state: false")
 
        # Werte überspringen
        string = string.substr(16)
        # Solarertrag
        value = hex2dec(string,4)
        string = string.substr(4)
        @se = value
        @emit "se", value
        # Werte überspringen
        string = string.substr(30)
        # Solarleistung
        value = hex2dec(string,4)
        string = string.substr(4)
        @sl = value
        @emit "sl", value

  solvisremote = new SolvisRemote
  return solvisremote

hex2dec = (hexstring, size) ->
  hexstring = hexstring.slice(0,size)
  chunkarray = []
  for i in [0...(size/2)]
    sstr = hexstring.substr(0,2)
    hexstring = hexstring.slice(2)
    chunkarray.push(sstr)
  if hexstring.length
    chunkarray.push(hexstring)
  for arsz in [chunkarray.length...0]
    hexstring += chunkarray[(arsz-1)]
  return parseInt(hexstring, 16)

