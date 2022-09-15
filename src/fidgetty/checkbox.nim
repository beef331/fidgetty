import fidget_dev
import widgets

fidgetty Checkbox:
  properties:
    checked: bool
    label: string
    isActive: bool
    disabled: bool
  state:
    empty: void

proc checkbox*(
): bool {.basicFidget, discardable.} =
  # Draw a progress bars
  init:
    box 0, 0, 8.Em, 2.Em

  render:

    onClick:
      checked = not checked

    text "label":
      box 100'ph, 0, parent.box.w - 100'ph, parent.box.h
      fill palette.text
      characters label

    rectangle "square":
      box 0, 0, 100'ph, 100'ph
      fill palette.foreground
      clipContent true
      imageOf theme.gloss
      if checked:
        highlight palette
        text "checkfil":
          fontSize 1.6 * fontSize()
          box 0.0, 0.0, 1.2 * fontSize(), 100'ph
          fill palette.text
          characters "✓"
      stroke theme.outerStroke
      cornerRadius theme
