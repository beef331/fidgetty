import std/strformat, std/hashes, std/sequtils

import fidgetty
import fidgetty/themes
import fidgetty/[button, dropdown, checkbox]
import fidgetty/[progressbar, animatedProgress]
# import fidgetty/[listbox]
# import fidgetty/[textinput]

loadFont("IBM Plex Sans", "IBMPlexSans-Regular.ttf")

fidgetty DemoApp:
  properties:
    count1: int
    count2: int
    value: float
    scrollValue: float
    myCheck: bool
    mySlider: float
    dropIndexes: int
    textInput: string

var self = DemoAppProps.new()

proc testDemo() =
  ## defines a stateful app widget
  let currEvents = useEvents()
  let dropItems = @["Nim", "UI", "in", "100%", "Nim", "to",
                    "OpenGL", "Immediate", "mode"]

  setTitle(fmt"Fidget Animated Progress Example")
  textStyle theme
  fill palette.background.lighten(0.11)

  group "center":
    box 50, 0, 100'vw - 100, 100'vh
    orgBox 50, 0, 100'vw, 100'vw
    fill palette.background.darken(1'PP)
    strokeWeight 1

    self.value = (self.count1.toFloat * 0.10) mod 1.0
    var delta = 0.0
    Vertical:
      blank: size(0, 0)
      itemSpacing 1.5'em

      Vertical:
        itemSpacing 1.5'em
        # Trigger an animation on animatedProgress below
        Button:
          size 10'em, 2'em
          label fmt"Arg Incr {self.count1:4d}"
          onClick:
            self.count1.inc()
            delta = 0.02
        Horizontal:
          itemSpacing 4'em
          Button:
            size 10'em, 2'em
            label &"Evt Incr {self.count2:4d}"
            onClick:
              self.count2.inc()
              # currEvents["pbc1"] = IncrementBar(increment = 0.02)
          Theme(warningPalette()):
            Checkbox:
              size 10'em, 2'em
              label fmt"Click {self.myCheck}"
              checked self.myCheck
              onClick:
                self.myCheck = not self.myCheck

      AnimatedProgress:
        # delta delta
        # bindEvents "pbc1", currEvents
        size 100.WPerc - 8'em, 2.Em

    #   Horizontal:
    #     Button(label = "Animate"):
    #       onClick:
    #         self.count2.inc()
    #         currEvents["pbc1"] = JumpToValue(target = 0.01)
    #     Button(label = "Cancel"):
    #       onClick:
    #         currEvents["pbc1"] = CancelJump()
    #     Dropdown:
    #       items: dropItems
    #       selected: self.dropIndexes
    #       defaultLabel: "Menu"
    #       setup: size 12'em, 2'em

    #   text "data":
    #     size 60'vw, 2'em
    #     fill "#000000"
    #     # characters: fmt"AnimatedProgress value: {ap1.value:>6.2f}"
    #     characters: fmt"selected: {self.dropIndexes}"
    #   Slider:
    #     value: ap1.value
    #     setup: size 60'vw, 2'em
    #   Listbox:
    #     items: dropItems
    #     selected: self.dropIndexes
    #     itemsVisible: 4
    #     setup:
    #       size 60'vw, 2'em
    #       bindEvents "lstbx", currEvents
    #   Slider:
    #     value: self.scrollValue
    #     setup: size 60'vw, 2'em
    #     changed:
    #       currEvents["lstbx"] = ScrollTo(self.scrollValue)
    #   TextInputBind:
    #     value: self.textInput
    #     setup: size 60'vw, 2'em
    #   Button(label = &"{self.textInput}"):
    #     disabled: true
    #     setup: size 60'vw, 2'em
    # palette.accent = parseHtml("#87E3FF", 0.67).spin(ap1.value * 36)

startFidget(
  testDemo,
  setup = 
    when defined(demoBulmaTheme): setup(bulmaTheme)
    else: setup(grayTheme),
  w = 640,
  h = 700,
  uiScale = 2.0
)
