; GridLines Meters ~ Perspective
; Coverage 1920x1080 pixels
; 5 lines per 100 pixels :: (1920/100)*5=96 vertical line meters | (1080/100)*5=54 horizontal line meters
; Meters are drawn from Perspective Pint outward to quartered screen edges
;
;-----------------------------------------------------------------------------------------------------------------
; Perspective Line Meters
;-----------------------------------------------------------------------------------------------------------------

[mAspectXSizeDnMin]
Measure=Calc
Formula=(#AspectXSize#-4<4)? 4:(#AspectXSize#-4)
DynamicVariables=1

[mAspectYSizeDnMin]
Measure=Calc
Formula=(#AspectYSize#-3<3)? 3:(#AspectYSize#-3)
DynamicVariables=1

[MeterPointA]
Meter=Image
X=#AspectX#
Y=#AspectY#
W=#AspectXSize#
H=#AspectYSize#
SolidColor=0,20,220
SolidColor2=#CenterLineColor#
GradientAngle=90
ImageAlpha=192
MouseScrollUpAction=[!SetVariable AspectYSize (#AspectYSize#+3)][!SetVariable AspectXSize (#AspectXSize#+4)][!Update][!Redraw]
MouseScrollDownAction=[!SetVariable AspectYSize ([mAspectYSizeDnMin])][!SetVariable AspectXSize ([mAspectXSizeDnMin])][!Update][!Redraw]
DynamicVariables=1

[MeterHorizonLine]
Meter=Image
X=25
Y=(#AspectY#+[MeterPointA:H]/2-3)
W=(#ScreenAreaWidth#-25)
H=6
SolidColor=0,20,220,210
SolidColor2=#CenterLineColor#
GradientAngle=90
DynamicVariables=1
Hidden=#HideHorizon#

[MeterPointHorizontal]
Meter=Image
X=#AspectX#
Y=0
W=([MeterPointA:W])
H=15
SolidColor=#CenterLineColor#
SolidColor2=0,20,220,255
GradientAngle=270
ImageAlpha=255
DynamicVariables=1

[MeterPointVertical]
Meter=Image
X=0
Y=#AspectY#
W=25
H=([MeterPointA:H])
SolidColor2=#CenterLineColor#
SolidColor=0,20,220,255
GradientAngle=90
ImageAlpha=255
DynamicVariables=1

[MeterLineToUpperLeft]
Meter=Roundline
X=([MeterPointA:X])
Y=([MeterPointA:Y])
LineColor=#CenterLineColor#
LineWidth=1
LineLength=((0-[MeterPointA:X])/Cos(Atan2(0-[MeterPointA:Y], 0-[MeterPointA:X])))
StartAngle=Rad(360)
RotationAngle=(Atan2(0-[MeterPointA:Y], 0-[MeterPointA:X]))
AntiAlias=1
DynamicVariables=1

[MeterLineToUpperRight]
Meter=Roundline
X=([MeterPointA:X]+[MeterPointA:W])
Y=([MeterPointA:Y])
LineColor=#CenterLineColor#
LineWidth=1
LineLength=((#ScreenAreaWidth#-[MeterPointA:X])/Cos(Atan2(0-[MeterPointA:Y], #ScreenAreaWidth#-[MeterPointA:X])))
StartAngle=Rad(360)
RotationAngle=(Atan2(0-[MeterPointA:Y], #ScreenAreaWidth#-[MeterPointA:X]))
AntiAlias=1
DynamicVariables=1

[MeterLineToLowerRight]
Meter=Roundline
X=([MeterPointA:X]+[MeterPointA:W])
Y=([MeterPointA:Y]+[MeterPointA:H])
LineColor=#CenterLineColor#
LineWidth=1
LineLength=((#ScreenAreaWidth#-[MeterPointA:X])/Cos(Atan2(#ScreenAreaHeight#-[MeterPointA:Y], #ScreenAreaWidth#-[MeterPointA:X])))
StartAngle=Rad(360)
RotationAngle=(Atan2(#ScreenAreaHeight#-[MeterPointA:Y], #ScreenAreaWidth#-[MeterPointA:X]))
AntiAlias=1
DynamicVariables=1

[MeterLineToLowerLeft]
Meter=Roundline
X=([MeterPointA:X])
Y=([MeterPointA:Y]+[MeterPointA:H])
LineColor=#CenterLineColor#
LineWidth=1
LineLength=((0-[MeterPointA:X])/Cos(Atan2(#ScreenAreaHeight#-[MeterPointA:Y], 0-[MeterPointA:X])))
StartAngle=Rad(360)
RotationAngle=(Atan2(#ScreenAreaHeight#-[MeterPointA:Y], 0-[MeterPointA:X]))
AntiAlias=1
DynamicVariables=1

[MeterLineToCenterTop]
Meter=Roundline
X=([MeterPointA:X]+([MeterPointA:W]*0.5))
Y=([MeterPointA:Y])
LineColor=#GridColor#
LineWidth=1
LineLength=(((#ScreenAreaWidth#*0.5)-[MeterPointA:X])/Cos(Atan2(0-[MeterPointA:Y], (#ScreenAreaWidth#*0.5)-[MeterPointA:X])))
StartAngle=Rad(360)
RotationAngle=(Atan2(0-[MeterPointA:Y], (#ScreenAreaWidth#*0.5)-[MeterPointA:X]))
AntiAlias=1
DynamicVariables=1

[MeterLineToCenterRight]
Meter=Roundline
X=([MeterPointA:X]+[MeterPointA:W])
Y=([MeterPointA:Y]+([MeterPointA:H]*0.5))
LineColor=#GridColor#
LineWidth=1
LineLength=((#ScreenAreaWidth#-[MeterPointA:X])/Cos(Atan2((#ScreenAreaHeight#*0.5)-[MeterPointA:Y], #ScreenAreaWidth#-[MeterPointA:X])))
StartAngle=Rad(360)
RotationAngle=(Atan2((#ScreenAreaHeight#*0.5)-[MeterPointA:Y], #ScreenAreaWidth#-[MeterPointA:X]))
AntiAlias=1
DynamicVariables=1

[MeterLineToCenterBottom]
Meter=Roundline
X=([MeterPointA:X]+([MeterPointA:W]*0.5))
Y=([MeterPointA:Y]+[MeterPointA:H])
LineColor=#GridColor#
LineWidth=1
LineLength=(((#ScreenAreaWidth#*0.5)-[MeterPointA:X])/Cos(Atan2(#ScreenAreaHeight#-[MeterPointA:Y], (#ScreenAreaWidth#*0.5)-[MeterPointA:X])))
StartAngle=Rad(360)
RotationAngle=(Atan2(#ScreenAreaHeight#-[MeterPointA:Y], (#ScreenAreaWidth#*0.5)-[MeterPointA:X]))
AntiAlias=1
DynamicVariables=1

[MeterLineToCenterLeft]
Meter=Roundline
X=([MeterPointA:X])
Y=([MeterPointA:Y]+([MeterPointA:H]*0.5))
LineColor=#GridColor#
LineWidth=1
LineLength=((0-[MeterPointA:X])/Cos(Atan2((#ScreenAreaHeight#*0.5)-[MeterPointA:Y], 0-[MeterPointA:X])))
StartAngle=Rad(360)
RotationAngle=(Atan2((#ScreenAreaHeight#*0.5)-[MeterPointA:Y], 0-[MeterPointA:X]))
AntiAlias=1
DynamicVariables=1

[MeterLineTo1QuarterTop]
Meter=Roundline
X=([MeterPointA:X]+([MeterPointA:W]*0.25))
Y=([MeterPointA:Y])
LineColor=#GridColor#
LineWidth=1
LineLength=(((#ScreenAreaWidth#*0.25)-[MeterPointA:X])/Cos(Atan2(0-[MeterPointA:Y], (#ScreenAreaWidth#*0.25)-[MeterPointA:X])))
StartAngle=Rad(360)
RotationAngle=(Atan2(0-[MeterPointA:Y], (#ScreenAreaWidth#*0.25)-[MeterPointA:X]))
AntiAlias=1
DynamicVariables=1

[MeterLineTo1QuarterRight]
Meter=Roundline
X=([MeterPointA:X]+[MeterPointA:W])
Y=([MeterPointA:Y]+([MeterPointA:H]*0.25))
LineColor=#GridColor#
LineWidth=1
LineLength=((#ScreenAreaWidth#-[MeterPointA:X])/Cos(Atan2((#ScreenAreaHeight#*0.25)-[MeterPointA:Y], #ScreenAreaWidth#-[MeterPointA:X])))
StartAngle=Rad(360)
RotationAngle=(Atan2((#ScreenAreaHeight#*0.25)-[MeterPointA:Y], #ScreenAreaWidth#-[MeterPointA:X]))
AntiAlias=1
DynamicVariables=1

[MeterLineTo1QuarterBottom]
Meter=Roundline
X=([MeterPointA:X]+([MeterPointA:W]*0.25))
Y=([MeterPointA:Y]+[MeterPointA:H])
LineColor=#GridColor#
LineWidth=1
LineLength=(((#ScreenAreaWidth#*0.25)-[MeterPointA:X])/Cos(Atan2(#ScreenAreaHeight#-[MeterPointA:Y], (#ScreenAreaWidth#*0.25)-[MeterPointA:X])))
StartAngle=Rad(360)
RotationAngle=(Atan2(#ScreenAreaHeight#-[MeterPointA:Y], (#ScreenAreaWidth#*0.25)-[MeterPointA:X]))
AntiAlias=1
DynamicVariables=1

[MeterLineTo1QuarterLeft]
Meter=Roundline
X=([MeterPointA:X])
Y=([MeterPointA:Y]+([MeterPointA:H]*0.25))
LineColor=#GridColor#
LineWidth=1
LineLength=((0-[MeterPointA:X])/Cos(Atan2((#ScreenAreaHeight#*0.25)-[MeterPointA:Y], 0-[MeterPointA:X])))
StartAngle=Rad(360)
RotationAngle=(Atan2((#ScreenAreaHeight#*0.25)-[MeterPointA:Y], 0-[MeterPointA:X]))
AntiAlias=1
DynamicVariables=1

[MeterLineTo3QuarterTop]
Meter=Roundline
X=([MeterPointA:X]+([MeterPointA:W]*0.75))
Y=([MeterPointA:Y])
LineColor=#GridColor#
LineWidth=1
LineLength=(((#ScreenAreaWidth#*0.75)-[MeterPointA:X])/Cos(Atan2(0-[MeterPointA:Y], (#ScreenAreaWidth#*0.75)-[MeterPointA:X])))
StartAngle=Rad(360)
RotationAngle=(Atan2(0-[MeterPointA:Y], (#ScreenAreaWidth#*0.75)-[MeterPointA:X]))
AntiAlias=1
DynamicVariables=1

[MeterLineTo3QuarterRight]
Meter=Roundline
X=([MeterPointA:X]+[MeterPointA:W])
Y=([MeterPointA:Y]+([MeterPointA:H]*0.75))
LineColor=#GridColor#
LineWidth=1
LineLength=((#ScreenAreaWidth#-[MeterPointA:X])/Cos(Atan2((#ScreenAreaHeight#*0.75)-[MeterPointA:Y], #ScreenAreaWidth#-[MeterPointA:X])))
StartAngle=Rad(360)
RotationAngle=(Atan2((#ScreenAreaHeight#*0.75)-[MeterPointA:Y], #ScreenAreaWidth#-[MeterPointA:X]))
AntiAlias=1
DynamicVariables=1

[MeterLineTo3QuarterBottom]
Meter=Roundline
X=([MeterPointA:X]+([MeterPointA:W]*0.75))
Y=([MeterPointA:Y]+[MeterPointA:H])
LineColor=#GridColor#
LineWidth=1
LineLength=(((#ScreenAreaWidth#*0.75)-[MeterPointA:X])/Cos(Atan2(#ScreenAreaHeight#-[MeterPointA:Y], (#ScreenAreaWidth#*0.75)-[MeterPointA:X])))
StartAngle=Rad(360)
RotationAngle=(Atan2(#ScreenAreaHeight#-[MeterPointA:Y], (#ScreenAreaWidth#*0.75)-[MeterPointA:X]))
AntiAlias=1
DynamicVariables=1

[MeterLineTo3QuarterLeft]
Meter=Roundline
X=([MeterPointA:X])
Y=([MeterPointA:Y]+([MeterPointA:H]*0.75))
LineColor=#GridColor#
LineWidth=1
LineLength=((0-[MeterPointA:X])/Cos(Atan2((#ScreenAreaHeight#*0.75)-[MeterPointA:Y], 0-[MeterPointA:X])))
StartAngle=Rad(360)
RotationAngle=(Atan2((#ScreenAreaHeight#*0.75)-[MeterPointA:Y], 0-[MeterPointA:X]))
AntiAlias=1
DynamicVariables=1
