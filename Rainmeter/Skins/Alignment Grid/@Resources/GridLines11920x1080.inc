; GridLines Meters ~ Centimeters
; Coverage 1920x1080 pixels
; 5 lines per 100 pixels :: (1920/100)*5=96 vertical line meters | (1080/100)*5=54 horizontal line meters
; Meters are drawn from Center-Line outward in all directions
;
;-----------------------------------------------------------------------------------------------------------------
; Horizontal Line Meters
;-----------------------------------------------------------------------------------------------------------------

[MeterHorizontalLine1B]
Meter=Image
X=0
Y=([MeterHorizontalCenterLine:Y]+(#Hor#*[MeasureCentimeter100px]/50))
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1

[MeterHorizontalLine2B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*2>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine3B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*3>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine4B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*4>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine5B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*5>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine6B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*6>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine7B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*7>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine8B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*8>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine9B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*9>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine10B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*10>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine11B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*11>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine12B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*12>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine13B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*13>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine14B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*14>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine15B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*15>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine16B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*16>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine17B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*17>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine18B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*18>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine19B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*19>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine20B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*20>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine21B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*21>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine22B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*22>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine23B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*23>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine24B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*24>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine25B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*25>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine26B]
Meter=Image
X=0
Y=(#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*26>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine1T]
Meter=Image
X=0
Y=(([MeterHorizontalCenterLine:Y])-#Hor#*[MeasureCentimeter100px]/50)
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*1>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine2T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*2>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine3T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*3>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine4T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*4>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine5T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*5>#SCREENAREAHEIGHT#?/2)

[MeterHorizontalLine6T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*6>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine7T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*7>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine8T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*8>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine9T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*9>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine10T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*10>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine11T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*11>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine12T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*12>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine13T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*13>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine14T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*14>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine15T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*15>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine16T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*16>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine17T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*17>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine18T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*18>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine19T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*19>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine20T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*20>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine21T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*21>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine22T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*22>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine23T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*23>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine24T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*24>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine25T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*25>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine26T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*26>#SCREENAREAHEIGHT#?)

[MeterHorizontalLine27T]
Meter=Image
X=0
Y=(-#Hor#*[MeasureCentimeter100px]/50)r
W=#SCREENAREAWIDTH#
H=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Hor#*27>#SCREENAREAHEIGHT#?)

;-----------------------------------------------------------------------------------------------------------------
; Vertical Line Meters
;-----------------------------------------------------------------------------------------------------------------


[MeterVerticalLine1R]
Meter=Image
Y=0
X=([MeterVerticalCenterLine:X]+#Ver#*[MeasureCentimeter100px]/50)
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1

[MeterVerticalLine2R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*2>#SCREENAREAWIDTH#?)

[MeterVerticalLine3R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*3>#SCREENAREAWIDTH#?)

[MeterVerticalLine4R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*4>#SCREENAREAWIDTH#?)

[MeterVerticalLine5R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*5>#SCREENAREAWIDTH#?)

[MeterVerticalLine6R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*6>#SCREENAREAWIDTH#?)

[MeterVerticalLine7R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*7>#SCREENAREAWIDTH#?)

[MeterVerticalLine8R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*8>#SCREENAREAWIDTH#?)

[MeterVerticalLine9R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*9>#SCREENAREAWIDTH#?)

[MeterVerticalLine10R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*10>#SCREENAREAWIDTH#?)

[MeterVerticalLine11R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*11>#SCREENAREAWIDTH#?)

[MeterVerticalLine12R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*12>#SCREENAREAWIDTH#?)

[MeterVerticalLine13R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*13>#SCREENAREAWIDTH#?)

[MeterVerticalLine14R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*14>#SCREENAREAWIDTH#?)

[MeterVerticalLine15R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*15>#SCREENAREAWIDTH#?)

[MeterVerticalLine16R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*16>#SCREENAREAWIDTH#?)

[MeterVerticalLine17R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*17>#SCREENAREAWIDTH#?)

[MeterVerticalLine18R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*18>#SCREENAREAWIDTH#?)

[MeterVerticalLine19R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*19>#SCREENAREAWIDTH#?)

[MeterVerticalLine20R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*20>#SCREENAREAWIDTH#?)

[MeterVerticalLine21R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*21>#SCREENAREAWIDTH#?)

[MeterVerticalLine22R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*22>#SCREENAREAWIDTH#?)

[MeterVerticalLine23R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*23>#SCREENAREAWIDTH#?)

[MeterVerticalLine24R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*24>#SCREENAREAWIDTH#?)

[MeterVerticalLine25R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*25>#SCREENAREAWIDTH#?)

[MeterVerticalLine26R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*26>#SCREENAREAWIDTH#?)

[MeterVerticalLine27R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*27>#SCREENAREAWIDTH#?)

[MeterVerticalLine28R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*28>#SCREENAREAWIDTH#?)

[MeterVerticalLine29R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*29>#SCREENAREAWIDTH#?)

[MeterVerticalLine30R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*30>#SCREENAREAWIDTH#?)

[MeterVerticalLine31R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*31>#SCREENAREAWIDTH#?)

[MeterVerticalLine32R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*32>#SCREENAREAWIDTH#?)

[MeterVerticalLine33R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*33>#SCREENAREAWIDTH#?)

[MeterVerticalLine34R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*34>#SCREENAREAWIDTH#?)

[MeterVerticalLine35R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*35>#SCREENAREAWIDTH#?)

[MeterVerticalLine36R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*36>#SCREENAREAWIDTH#?)

[MeterVerticalLine37R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*37>#SCREENAREAWIDTH#?)

[MeterVerticalLine38R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*38>#SCREENAREAWIDTH#?)

[MeterVerticalLine39R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*39>#SCREENAREAWIDTH#?)

[MeterVerticalLine40R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*40>#SCREENAREAWIDTH#?)

[MeterVerticalLine41R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*41>#SCREENAREAWIDTH#?)

[MeterVerticalLine42R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*42>#SCREENAREAWIDTH#?)

[MeterVerticalLine43R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*43>#SCREENAREAWIDTH#?)

[MeterVerticalLine44R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*44>#SCREENAREAWIDTH#?)

[MeterVerticalLine45R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*45>#SCREENAREAWIDTH#?)

[MeterVerticalLine46R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*46>#SCREENAREAWIDTH#?)

[MeterVerticalLine47R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*47>#SCREENAREAWIDTH#?)

[MeterVerticalLine48R]
Meter=Image
Y=0
X=(#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*48>#SCREENAREAWIDTH#?)

[MeterVerticalLine1L]
Meter=Image
Y=0
X=(([MeterVerticalCenterLine:X])-#Ver#*[MeasureCentimeter100px]/50)
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*1>#SCREENAREAWIDTH#?)

[MeterVerticalLine2L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*2>#SCREENAREAWIDTH#?)

[MeterVerticalLine3L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*3>#SCREENAREAWIDTH#?)

[MeterVerticalLine4L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*4>#SCREENAREAWIDTH#?)

[MeterVerticalLine5L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*5>#SCREENAREAWIDTH#?/2)

[MeterVerticalLine6L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*6>#SCREENAREAWIDTH#?)

[MeterVerticalLine7L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*7>#SCREENAREAWIDTH#?)

[MeterVerticalLine8L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*8>#SCREENAREAWIDTH#?)

[MeterVerticalLine9L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*9>#SCREENAREAWIDTH#?)

[MeterVerticalLine10L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*10>#SCREENAREAWIDTH#?)

[MeterVerticalLine11L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*11>#SCREENAREAWIDTH#?)

[MeterVerticalLine12L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*12>#SCREENAREAWIDTH#?)

[MeterVerticalLine13L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*13>#SCREENAREAWIDTH#?)

[MeterVerticalLine14L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*14>#SCREENAREAWIDTH#?)

[MeterVerticalLine15L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*15>#SCREENAREAWIDTH#?)

[MeterVerticalLine16L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*16>#SCREENAREAWIDTH#?)

[MeterVerticalLine17L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*17>#SCREENAREAWIDTH#?)

[MeterVerticalLine18L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*18>#SCREENAREAWIDTH#?)

[MeterVerticalLine19L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*19>#SCREENAREAWIDTH#?)

[MeterVerticalLine20L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*20>#SCREENAREAWIDTH#?)

[MeterVerticalLine21L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*21>#SCREENAREAWIDTH#?)

[MeterVerticalLine22L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*22>#SCREENAREAWIDTH#?)

[MeterVerticalLine23L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*23>#SCREENAREAWIDTH#?)

[MeterVerticalLine24L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*24>#SCREENAREAWIDTH#?)

[MeterVerticalLine25L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*25>#SCREENAREAWIDTH#?)

[MeterVerticalLine26L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*26>#SCREENAREAWIDTH#?)

[MeterVerticalLine27L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*27>#SCREENAREAWIDTH#?)

[MeterVerticalLine28L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*28>#SCREENAREAWIDTH#?)

[MeterVerticalLine29L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*29>#SCREENAREAWIDTH#?)

[MeterVerticalLine30L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*30>#SCREENAREAWIDTH#?)

[MeterVerticalLine31L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*31>#SCREENAREAWIDTH#?)

[MeterVerticalLine32L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*32>#SCREENAREAWIDTH#?)

[MeterVerticalLine33L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*33>#SCREENAREAWIDTH#?)

[MeterVerticalLine34L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*34>#SCREENAREAWIDTH#?)

[MeterVerticalLine35L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*35>#SCREENAREAWIDTH#?)

[MeterVerticalLine36L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*36>#SCREENAREAWIDTH#?)

[MeterVerticalLine37L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*37>#SCREENAREAWIDTH#?)

[MeterVerticalLine38L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*38>#SCREENAREAWIDTH#?)

[MeterVerticalLine39L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*39>#SCREENAREAWIDTH#?)

[MeterVerticalLine40L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*40>#SCREENAREAWIDTH#?)

[MeterVerticalLine41L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*41>#SCREENAREAWIDTH#?)

[MeterVerticalLine42L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*42>#SCREENAREAWIDTH#?)

[MeterVerticalLine43L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*43>#SCREENAREAWIDTH#?)

[MeterVerticalLine44L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*44>#SCREENAREAWIDTH#?)

[MeterVerticalLine45L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*45>#SCREENAREAWIDTH#?)

[MeterVerticalLine46L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*46>#SCREENAREAWIDTH#?)

[MeterVerticalLine47L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*47>#SCREENAREAWIDTH#?)

[MeterVerticalLine48L]
Meter=Image
Y=0
X=(-#Ver#*[MeasureCentimeter100px]/50)r
H=#SCREENAREAHEIGHT#
W=1
SolidColor=#GridColor#
DynamicVariables=1
Hidden=(#Ver#*48>#SCREENAREAWIDTH#?)

