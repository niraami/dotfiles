[MeterHorizontalRuler]
Meter=Image
MeterStyle=HorizontalRulerStyle
X=0
Y=0
W=#SCREENAREAWIDTH#
H=15
SolidColor=255,255,255,160
DynamicVariables=1
LeftMouseDownAction=[!SetTransparency "#PreviewTransparency#"]
LeftMouseDoubleClickAction=[!SetVariable AspectX $MouseX$][!WriteKeyValue Variables AspectX $MouseX$][!Update][!Redraw]
LeftMouseUpAction=[!SetTransparency "255"]
MouseScrollDownAction=[!SetVariable Ver [mGridNarrow]][!WriteKeyValue Variables Ver [mGridNarrow]][!Update][!Redraw]
MouseScrollUpAction=[!SetVariable Ver [mGridWide]][!WritekeyValue Variables Ver [mGridWide]][!Update][!Redraw]
RightMouseUpAction=[!ActivateConfig "Alignment Grid\Context" "Context#Unit#Horizontal.ini"]
ToolTipTitle="Dimming & Horizontal Spacing"
ToolTipText="DIMMING: Left-click & Hold to dim the grid#CRLF#                  Move away and Release to maintain dimming#CRLF##CRLF#SPACING: Scroll Up/Down to change Horizontal spacing#CRLF#                  Right-click for Quick Spacing menu#CRLF##CRLF#ASPECT-X: Double-Left-click to set X position of Aspect view"

[MeterHorizontalRuler0]
Meter=Image
X=[MeterVerticalCenterLine:X]
MeterStyle=HorizontalRulerStyle
DynamicVariables=1

[MeterHorizontalRuler0Text]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
AntiAlias=1
Text=0

[MeterHorizontalRuler1R]
Meter=Image
X=([MeterVerticalCenterLine:X]+[MeasureCentimeter100px])
MeterStyle=HorizontalRulerStyle
DynamicVariables=1

[MeterHorizontalRuler1RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
AntiAlias=1
Text=1#Zeros#

[MeterHorizontalRuler2R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*2?)

[MeterHorizontalRuler2RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=2#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*2?)

[MeterHorizontalRuler3R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*3?)

[MeterHorizontalRuler3RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=3#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*3?)

[MeterHorizontalRuler4R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*4?)

[MeterHorizontalRuler4RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=4#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*4?)

[MeterHorizontalRuler5R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*5?)

[MeterHorizontalRuler5RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=5#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*5?)

[MeterHorizontalRuler6R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*6?)

[MeterHorizontalRuler6RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=6#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*6?)

[MeterHorizontalRuler7R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*7?)

[MeterHorizontalRuler7RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=7#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*7?)

[MeterHorizontalRuler8R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*8?)

[MeterHorizontalRuler8RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=8#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*8?)

[MeterHorizontalRuler9R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*9?)

[MeterHorizontalRuler9RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=9#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*9?)

[MeterHorizontalRuler10R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeterHorizontalRuler10R:X]?)

[MeterHorizontalRuler10RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=10#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*10?)

[MeterHorizontalRuler11R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*11?)
DynamicVariables=1

[MeterHorizontalRuler11RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
AntiAlias=1
Text=11#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*11?)

[MeterHorizontalRuler12R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*12?)

[MeterHorizontalRuler12RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=12#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*12?)

[MeterHorizontalRuler13R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*13?)

[MeterHorizontalRuler13RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=13#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*13?)

[MeterHorizontalRuler14R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*14?)

[MeterHorizontalRuler14RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=14#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*14?)

[MeterHorizontalRuler15R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*15?)

[MeterHorizontalRuler15RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=15#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*15?)

[MeterHorizontalRuler16R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*16?)

[MeterHorizontalRuler16RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=16#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*16?)

[MeterHorizontalRuler17R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*17?)

[MeterHorizontalRuler17RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=17#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*17?)

[MeterHorizontalRuler18R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*18?)

[MeterHorizontalRuler18RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=18#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*18?)

[MeterHorizontalRuler19R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*19?)

[MeterHorizontalRuler19RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=19#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*19?)

[MeterHorizontalRuler20R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*20?)

[MeterHorizontalRuler20RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=20#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*20?)

[MeterHorizontalRuler21R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*21?)
DynamicVariables=1

[MeterHorizontalRuler21RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
AntiAlias=1
Text=21#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*21?)

[MeterHorizontalRuler22R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*22?)

[MeterHorizontalRuler22RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=22#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*22?)

[MeterHorizontalRuler23R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*23?)

[MeterHorizontalRuler23RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=23#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*23?)

[MeterHorizontalRuler24R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*24?)

[MeterHorizontalRuler24RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=24#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*24?)

[MeterHorizontalRuler25R]
Meter=Image
X=([MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*25?)

[MeterHorizontalRuler25RText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=25#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*25?)

;========================================================================================================

[MeterHorizontalRuler1L]
Meter=Image
X=([MeterVerticalCenterLine:X]-[MeasureCentimeter100px])
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]?)

[MeterHorizontalRuler1LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-1#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]?)

[MeterHorizontalRuler2L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*2?)

[MeterHorizontalRuler2LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-2#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*2?)

[MeterHorizontalRuler3L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*3?)

[MeterHorizontalRuler3LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-3#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*3?)

[MeterHorizontalRuler4L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*4?)

[MeterHorizontalRuler4LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-4#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*4?)

[MeterHorizontalRuler5L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*5?)

[MeterHorizontalRuler5LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-5#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*5?)

[MeterHorizontalRuler6L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*6?)

[MeterHorizontalRuler6LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-6#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*6?)

[MeterHorizontalRuler7L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*7?)

[MeterHorizontalRuler7LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-7#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*7?)

[MeterHorizontalRuler8L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*8?)

[MeterHorizontalRuler8LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-8#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*8?)

[MeterHorizontalRuler9L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*9?)

[MeterHorizontalRuler9TextL]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-9#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*9?)

[MeterHorizontalRuler10L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*10?)

[MeterHorizontalRuler10LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-10#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*10?)

[MeterHorizontalRuler11L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*11?)

[MeterHorizontalRuler11LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-11#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*11?)

[MeterHorizontalRuler12L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*12?)

[MeterHorizontalRuler12LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-12#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*12?)

[MeterHorizontalRuler13L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*13?)

[MeterHorizontalRuler13LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-13#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*13?)

[MeterHorizontalRuler14L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*14?)

[MeterHorizontalRuler14LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-14#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*14?)

[MeterHorizontalRuler15L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*15?)

[MeterHorizontalRuler15LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-15#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*15?)

[MeterHorizontalRuler16L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*16?)

[MeterHorizontalRuler16LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-16#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*16?)

[MeterHorizontalRuler17L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*17?)

[MeterHorizontalRuler17LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-17#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*17?)

[MeterHorizontalRuler18L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*18?)

[MeterHorizontalRuler18LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-18#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*18?)

[MeterHorizontalRuler19L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*19?)

[MeterHorizontalRuler19TextL]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-19#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*19?)

[MeterHorizontalRuler20L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*20?)

[MeterHorizontalRuler20LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-20#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*20?)

[MeterHorizontalRuler21L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*21?)

[MeterHorizontalRuler21LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-21#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*21?)

[MeterHorizontalRuler22L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*22?)

[MeterHorizontalRuler22LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-22#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*22?)

[MeterHorizontalRuler23L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*23?)

[MeterHorizontalRuler23LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-23#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*23?)

[MeterHorizontalRuler24L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*24?)

[MeterHorizontalRuler24LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-24#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*24?)

[MeterHorizontalRuler25L]
Meter=Image
X=(-[MeasureCentimeter100px])r
MeterStyle=HorizontalRulerStyle
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*25?)

[MeterHorizontalRuler25LText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-25#Zeros#
Hidden=(#SCREENAREAWIDTH#<[MeasureCentimeter100px]*25?)

;-----------------------------------------------------------------------------------------------------------------
; VERTICAL RULER METERS
;-----------------------------------------------------------------------------------------------------------------

[MeterVerticalRuler]
Meter=Image
X=0
Y=0
W=25
H=#SCREENAREAHEIGHT#
SolidColor=255,255,255,160
DynamicVariables=1
LeftMouseDownAction=[!SetTransparency "#PreviewTransparency#"]
LeftMouseDoubleClickAction=[!SetVariable AspectY $MouseY$][!WriteKeyValue Variables AspectY $MouseY$][!Update][!Redraw]
LeftMouseUpAction=[!SetTransparency "255"]
MouseScrollDownAction=[!SetVariable Hor [mGridShort]][!WriteKeyValue Variables Hor [mGridShort]][!Update][!Redraw]
MouseScrollUpAction=[!SetVariable Hor [mGridTall]][!WriteKeyValue Variables Hor [mGridTall]][!Update][!Redraw]
RightMouseUpAction=[!ActivateConfig "Alignment Grid\Context" "Context#Unit#Vertical.ini"]
ToolTipTitle="Dimming & Vertical Spacing"
ToolTipText="DIMMING: Left-click & Hold to dim the grid#CRLF#                  Move away and Release to maintain dimming#CRLF##CRLF#SPACING: Scroll Up/Down to change Vertical spacing#CRLF#                  Right-click for Quick Spacing menu#CRLF##CRLF#ASPECT-Y: Double-Let-click to set Y position of Aspect view"

[MeterVerticalRuler0]
Meter=Image
Y=[MeterHorizontalCenterLine:Y]
MeterStyle=VerticalRulerStyle

[MeterVerticalRuler0Text]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=0

[MeterVerticalRuler1B]
Meter=Image
Y=([MeterHorizontalCenterLine:Y]+[MeasureCentimeter100px])
MeterStyle=VerticalRulerStyle

[MeterVerticalRuler1Text]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=1#Zeros#

[MeterVerticalRuler2B]
Meter=Image
Y=([MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*2?)

[MeterVerticalRuler2BText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=2#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*2?)

[MeterVerticalRuler3B]
Meter=Image
Y=([MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*3?)

[MeterVerticalRuler3BText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=3#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*3?)

[MeterVerticalRuler4B]
Meter=Image
Y=([MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*4?)

[MeterVerticalRuler4BText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=4#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*4?)

[MeterVerticalRuler5B]
Meter=Image
Y=([MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*5?)

[MeterVerticalRuler5BText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=5#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*5?)

[MeterVerticalRuler6B]
Meter=Image
Y=([MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*6?)

[MeterVerticalRuler6BText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=6#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*6?)

[MeterVerticalRuler7B]
Meter=Image
Y=([MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*7?)

[MeterVerticalRuler7BText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=7#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*7?)

[MeterVerticalRuler8B]
Meter=Image
Y=([MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*8?)

[MeterVerticalRuler8BText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=8#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*8?)

[MeterVerticalRuler9B]
Meter=Image
Y=([MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*9?)

[MeterVerticalRuler9BText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=9#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*9?)

[MeterVerticalRuler10B]
Meter=Image
Y=([MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*10?)

[MeterVerticalRuler10BText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=10#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*10?)

[MeterVerticalRuler11B]
Meter=Image
Y=([MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*11?)

[MeterVerticalRuler11BText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=11#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*11?)

[MeterVerticalRuler12B]
Meter=Image
Y=([MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*12?)

[MeterVerticalRuler12BText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=12#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*12?)

[MeterVerticalRuler13B]
Meter=Image
Y=([MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*13?)

[MeterVerticalRuler13BText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=13#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*13?)

[MeterVerticalRuler14B]
Meter=Image
Y=([MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*14?)

[MeterVerticalRuler14BText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=14#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*14?)

;=======================================================================================================

[MeterVerticalRuler1T]
Meter=Image
Y=([MeterHorizontalCenterLine:Y]-[MeasureCentimeter100px])
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*1?)

[MeterVerticalRuler1TText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-1#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*1?)

[MeterVerticalRuler2T]
Meter=Image
Y=(-[MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*2?)

[MeterVerticalRuler2TText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-2#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*2?)

[MeterVerticalRuler3T]
Meter=Image
Y=(-[MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*3?)

[MeterVerticalRuler3TText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-3#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*3?)

[MeterVerticalRuler4T]
Meter=Image
Y=(-[MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*4?)

[MeterVerticalRuler4TText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-4#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*4?)

[MeterVerticalRuler5T]
Meter=Image
Y=(-[MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*5?)

[MeterVerticalRuler5TText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-5#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*5?)

[MeterVerticalRuler6T]
Meter=Image
Y=(-[MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*6?)

[MeterVerticalRuler6TText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-6#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*6?)

[MeterVerticalRuler7T]
Meter=Image
Y=(-[MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*7?)

[MeterVerticalRuler7TText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-7#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*7?)

[MeterVerticalRuler8T]
Meter=Image
Y=(-[MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*8?)

[MeterVerticalRuler8TText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-8#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*8?)

[MeterVerticalRuler9T]
Meter=Image
Y=(-[MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*9?)

[MeterVerticalRuler9TText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-9#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*9?)

[MeterVerticalRuler10T]
Meter=Image
Y=(-[MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*10?)

[MeterVerticalRuler10TText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-10#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*10?)

[MeterVerticalRuler11T]
Meter=Image
Y=(-[MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*11?)

[MeterVerticalRuler11TText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-11#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*11?)

[MeterVerticalRuler12T]
Meter=Image
Y=(-[MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*12?)

[MeterVerticalRuler12TText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-12#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*12?)

[MeterVerticalRuler13T]
Meter=Image
Y=(-[MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*13?)

[MeterVerticalRuler13TText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-13#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*13?)

[MeterVerticalRuler14T]
Meter=Image
Y=(-[MeasureCentimeter100px])r
MeterStyle=VerticalRulerStyle
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*14?)

[MeterVerticalRuler14TText]
Meter=STRING
X=0r
Y=0r
MeterStyle=TagStyle
Text=-14#Zeros#
Hidden=(#SCREENAREAHEIGHT#<[MeasureCentimeter100px]*14?)

