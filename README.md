pimatic-solvisremote
====================

SolvisRemote plugin for <a href="https://pimatic.org">Pimatic</a> to get values from a SolvisMax solar heating system

The plugin is only tested with a SolvisMax 6 gas with solar panels. It should also work with a new SolvisMax 7.

# Plugin Configuration
Edit your config.json and include the following lines in the plugins section.

    {
      "plugin": "solvisremote"
    }

It is possible to enable debugging 

    {
      "plugin": "solvisremote",
      "debug": true
    }

# Device Configuration

Debices must be added manually to the device section of your pimatic config.

## Global device configuration

    {
      "id": "SolvisRemote",
      "name": "SolvisRemote",
      "class": "SolvisRemotedevice",
      "ip": "192.168.178.61",
      "user": "solvis",
      "pass": "solvis",
      "interval": 10,
      "xLink": "http://192.168.178.61/schema.html",
      ...
    }

## Sensor/In/Out/State configuration

To get values with pimatic like temperature from "S1", add following lines after "xLink":

    "s1": {
      "label": "Warmwasserpuffer"
    },

To get the state of the solar pump add these lines:

    "a1_state": {
      "label": "Solaranlage"
    },

Only added values are displayed. So it is possible to build your own SolvisMax environment. All possible values are listet in device-config-schema.

The "label"-attribute let your values be more readable. Best way to collect the data for your environment is to open SolvisRemote in a browser and open the
system scheme in the mobile view. Have a look at the sourcecode of the "schemam.html". Scroll down to the BODY-tag and you'll find the needed information.

## Full example

Here is an full example of a SolvisMax 6 with gas and solarpanels

    {
      "id": "SolvisRemote",
      "name": "SolvisRemote",
      "class": "SolvisRemotedevice",
      "ip": "192.168.178.61",
      "user": "solvis",
      "pass": "solvis",
      "interval": 10,
      "xLink": "http://192.168.178.61/schema.html",
      "s1": {
        "label": "Warmwasserpuffer"
      },
      "s2": {
        "label": "Warmwassertemperatur"
      },
      "s3": {
        "label": "Speicherreferenz"
      },
      "s4": {
        "label": "Heizungspuffer_oben"
      },
      "s5": {
        "label": "Solarvorlauftemperatur"
      },
      "s6": {
        "label": "Solarrücklauftemperatur"
      },
      "s8": {
        "label": "Kollektortemperatur"
      },
      "s9": {
        "label": "Heizungspuffer_unten"
      },
      "s10": {
        "label": "Außentemperatur"
      },
      "s11": {
        "label": "Zirkulationstemperatur"
      },
      "s12": {
        "label": "Vorlauftemperatur"
      },
      "s18": {
        "label": "Warmwasser-Durchfluss"
      },
      "a1_state": {
        "label": "Solaranlage"
      },
      "a2_state": {
        "label": "Warmwasserpumpe"
      },
      "a3_state": {
        "label": "Heizkreispumpe"
      },
      "a5_state": {
        "label": "Zirkulationspumpe"
      },
      "a12_state": {
        "label": "Nachheizung"
      }
    }
