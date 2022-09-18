import fidget_dev
import widgets

fidgetty ProgressBar:
  properties:
    value: float
    label: string
  state:
    empty: void

proc new*(_: typedesc[ProgressBarProps]): ProgressBarProps =
  new result
  box 0, 0, 100.WPerc, 2.Em
  textAutoResize tsHeight
  layoutAlign laStretch
  stroke theme.outerStroke

proc render*(
    props: ProgressBarProps,
    self: ProgressBarState,
): Events =
  ## Draw a progress bars 

  let
    # some basic calcs
    bw = current.box.w
    bh = current.box.h
    sb = 0.3'em
    sbb = 2.0*sb
    wcalc = bw * props.value.clamp(0, 1.0).UICoord - sbb + 0.001
    barW = wcalc.clamp(0.0, bw-sb)
    barH = bh - sb

  if props.label.len() > 0:
    text "text":
      box 0, 0, bw, bh
      fill palette.text
      characters props.label

  rectangle "barFgTexture":
    box sb, sb, barW, barH-sb
    cornerRadius 0.80 * theme.cornerRadius[0]
    clipContent true
    # strokeLine 1.0, "#707070", 0.87

  rectangle "barFgColor":
    box sb, sb, barW, barH-sb
    fill palette.accent
    cornerRadius 0.80 * theme.cornerRadius[0]
    imageOf theme.gloss, 0.67
    clipContent true
    stroke theme.innerStroke

  rectangle "bar":
    # Draw the bar itself.
    box 0, 0, bw, bh
    stroke theme.outerStroke
    fill palette.foreground
    cornerRadius 1.0 * theme.cornerRadius[0]

  # rectangle "bezel":
  #   cornerRadius 0.80 * theme.cornerRadius[0]
  #   box 0, 0, 100'pw, 100'ph
  #   rotation 180
  #   imageOf theme.gloss

  cornerRadius 1.0 * theme.cornerRadius[0]