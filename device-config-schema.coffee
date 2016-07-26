module.exports = {
  title: "pimatic-solvisremote device config schemas"
  SolvisRemotedevice: {
    title: "SolvisRemote device config options"
    type: "object"
    extensions: ["xLink"]
    properties: 
      ip:
        description: "SolvisRemote IP"
        format: String
        default: "192.168.178.10"
      user:
        description: "SolvisRemote User"
        format: String
        default: "solvis"
      pass:
        description: "SolvisRemote Password"
        format: String
        default: "solvis"
      interval:
        description: "Poll interval"
        format: Number
        default: 20      
      s1:
        description: "S1 - Label"
        label: String
        required: false
      s2:
        description: "S2 - Label"
        label: String
        required: false
      s3:
        description: "S3 - Label"
        label: String
        required: false
      s4:
        description: "S4 - Label"
        label: String
        required: false
      s5:
        description: "S5 - Label"
        label: String
        required: false
      s6:
        description: "S6 - Label"
        label: String
        required: false
      s7:
        description: "S7 - Label"
        label: String
        required: false
      s8:
        description: "S8 - Label"
        label: String
        required: false
      s9:
        description: "S9 - Label"
        label: String
        required: false
      s10:
        description: "S10 - Label"
        label: String
        required: false
      s11:
        description: "S11 - Label"
        label: String
        required: false
      s12:
        description: "S12 - Label"
        label: String
        required: false
      s13:
        description: "S13 - Label"
        label: String
        required: false
      s14:
        description: "S14 - Label"
        label: String
        required: false
      s15:
        description: "S15 - Label"
        label: String
        required: false
      s16:
        description: "S16 - Label"
        label: String
        required: false
      s17:
        description: "S17 - Label"
        label: String
        required: false
      s18:
        description: "S18 - Label"
        label: String
        required: false
      rf1:
        description: "RF1 - Label"
        label: String
        required: false
      rf2:
        description: "RF1 - Label"
        label: String
        required: false
      rf3:
        description: "RF1 - Label"
        label: String
        required: false
      a1:
        description: "A1 - Label"
        label: String
        required: false
      a2:
        description: "A2 - Label"
        label: String
        required: false
      a3:
        description: "A3 - Label"
        label: String
        required: false
      a4:
        description: "A4 - Label"
        label: String
        required: false
      a5:
        description: "A5 - Label"
        label: String
        required: false
      a6:
        description: "A6 - Label"
        label: String
        required: false
      a7:
        description: "A7 - Label"
        label: String
        required: false
      a8:
        description: "A8 - Label"
        label: String
        required: false
      a9:
        description: "A9 - Label"
        label: String
        required: false
      a10:
        description: "A10 - Label"
        label: String
        required: false
      a11:
        description: "A11 - Label"
        label: String
        required: false
      a12:
        description: "A12 - Label"
        label: String
        required: false
      a13:
        description: "A13 - Label"
        label: String
        required: false
      a14:
        description: "A14 - Label"
        label: String
        required: false
      a1_state:
        description: "A1_State - Label"
        label: String
        required: false
      a2_state:
        description: "A2_State - Label"
        label: String
        required: false
      a3_state:
        description: "A3_State - Label"
        label: String
        required: false
      a4_state:
        description: "A4_State - Label"
        label: String
        required: false
      a5_state:
        description: "A5_State - Label"
        label: String
        required: false
      a6_state:
        description: "A6_State - Label"
        label: String
        required: false
      a7_state:
        description: "A7_State - Label"
        label: String
        required: false
      a8_state:
        description: "A8_State - Label"
        label: String
        required: false
      a9_state:
        description: "A9_State - Label"
        label: String
        required: false
      a10_state:
        description: "A10_State - Label"
        label: String
        required: false
      a11_state:
        description: "A11_State - Label"
        label: String
        required: false
      a12_state:
        description: "A12_State - Label"
        label: String
        required: false
      a13_state:
        description: "A13_State - Label"
        label: String
        required: false
      a14_state:
        description: "A14_State - Label"
        label: String
        required: false
      se:
        description: "SE - Label"
        label: String
        required: false
      sl:
        description: "SL - Label"
        label: String
        required: false
  }
} 
