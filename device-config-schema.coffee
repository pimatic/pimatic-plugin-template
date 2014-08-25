# #my-device configuration options
# http://json-schema.org/documentation.html
module.exports ={
  title: "pimatic-my-plugin device config schemas"
  MySwitch: {
    title: "MySwitch config options"
    type: "object"
    properties:
      someOption:
        description: "The some option"
        type: "number"
        default: 42
}