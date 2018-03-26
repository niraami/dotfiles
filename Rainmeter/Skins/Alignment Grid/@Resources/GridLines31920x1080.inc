; GridLines Meters ~ Circles 
; Coverage 1920x1080 pixels
; 5 lines per 100 pixels :: (1920/100)*5=96 vertical line meters | (1080/100)*5=54 horizontal line meters
; Meters are drawn from Center-Line outward in all directions
;
;-----------------------------------------------------------------------------------------------------------------
; Circular Line Meters
;-----------------------------------------------------------------------------------------------------------------

[MeterCircle1]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#)/2)
W=(#Hor#)
H=(#Hor#)
StartAngle=4.712
RotationAngle=6.283
LineStart=#Hor#
LineLength=(#Hor#-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1

[MeterCircle2]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*2)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*2)/2)
W=(#Hor#*2)
H=(#Hor#*2)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*2)
LineLength=(#Hor#*2-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*2)

[MeterCircle3]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*3)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*3)/2)
W=(#Hor#*3)
H=(#Hor#*3)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*3)
LineLength=(#Hor#*3-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*3)

[MeterCircle4]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*4)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*4)/2)
W=(#Hor#*4)
H=(#Hor#*4)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*4)
LineLength=(#Hor#*4-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*4)

[MeterCircle5]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*5)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*5)/2)
W=(#Hor#*5)
H=(#Hor#*5)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*5)
LineLength=(#Hor#*5-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*5)

[MeterCircle6]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*6)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*6)/2)
W=(#Hor#*6)
H=(#Hor#*6)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*6)
LineLength=(#Hor#*6-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*6)

[MeterCircle7]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*7)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*7)/2)
W=(#Hor#*7)
H=(#Hor#*7)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*7)
LineLength=(#Hor#*7-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*7)

[MeterCircle8]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*8)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*8)/2)
W=(#Hor#*8)
H=(#Hor#*8)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*8)
LineLength=(#Hor#*8-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*8)

[MeterCircle9]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*9)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*9)/2)
W=(#Hor#*9)
H=(#Hor#*9)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*9)
LineLength=(#Hor#*9-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*9)

[MeterCircle10]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*10)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*10)/2)
W=(#Hor#*10)
H=(#Hor#*10)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*10)
LineLength=(#Hor#*10-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*10)

[MeterCircle11]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*11)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*11)/2)
W=(#Hor#*11)
H=(#Hor#*11)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*11)
LineLength=(#Hor#*11-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*11)

[MeterCircle12]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*12)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*12)/2)
W=(#Hor#*12)
H=(#Hor#*12)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*12)
LineLength=(#Hor#*12-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*12)

[MeterCircle13]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*13)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*13)/2)
W=(#Hor#*13)
H=(#Hor#*13)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*13)
LineLength=(#Hor#*13-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*13)

[MeterCircle14]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*14)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*14)/2)
W=(#Hor#*14)
H=(#Hor#*14)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*14)
LineLength=(#Hor#*14-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*14)

[MeterCircle15]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*15)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*15)/2)
W=(#Hor#*15)
H=(#Hor#*15)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*15)
LineLength=(#Hor#*15-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*15)

[MeterCircle16]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*16)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*16)/2)
W=(#Hor#*16)
H=(#Hor#*16)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*16)
LineLength=(#Hor#*16-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*16)

[MeterCircle17]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*17)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*17)/2)
W=(#Hor#*17)
H=(#Hor#*17)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*17)
LineLength=(#Hor#*17-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*17)

[MeterCircle18]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*18)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*18)/2)
W=(#Hor#*18)
H=(#Hor#*18)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*18)
LineLength=(#Hor#*18-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*18)

[MeterCircle19]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*19)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*19)/2)
W=(#Hor#*19)
H=(#Hor#*19)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*19)
LineLength=(#Hor#*19-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*19)

[MeterCircle20]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*20)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*20)/2)
W=(#Hor#*20)
H=(#Hor#*20)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*20)
LineLength=(#Hor#*20-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*20)

[MeterCircle21]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*21)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*21)/2)
W=(#Hor#*21)
H=(#Hor#*21)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*21)
LineLength=(#Hor#*21-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*21)

[MeterCircle22]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*22)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*22)/2)
W=(#Hor#*22)
H=(#Hor#*22)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*22)
LineLength=(#Hor#*22-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*22)

[MeterCircle23]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*23)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*23)/2)
W=(#Hor#*23)
H=(#Hor#*23)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*23)
LineLength=(#Hor#*23-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*23)

[MeterCircle24]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*24)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*24)/2)
W=(#Hor#*24)
H=(#Hor#*24)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*24)
LineLength=(#Hor#*24-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*24)

[MeterCircle25]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*25)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*25)/2)
W=(#Hor#*25)
H=(#Hor#*25)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*25)
LineLength=(#Hor#*25-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*25)

[MeterCircle26]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*26)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*26)/2)
W=(#Hor#*26)
H=(#Hor#*26)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*26)
LineLength=(#Hor#*26-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*26)

[MeterCircle27]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*27)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*27)/2)
W=(#Hor#*27)
H=(#Hor#*27)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*27)
LineLength=(#Hor#*27-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*27)

[MeterCircle28]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*28)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*28)/2)
W=(#Hor#*28)
H=(#Hor#*28)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*28)
LineLength=(#Hor#*28-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*28)

[MeterCircle29]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*29)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*29)/2)
W=(#Hor#*29)
H=(#Hor#*29)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*29)
LineLength=(#Hor#*29-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*29)

[MeterCircle30]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*30)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*30)/2)
W=(#Hor#*30)
H=(#Hor#*30)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*30)
LineLength=(#Hor#*30-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*30)

[MeterCircle31]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*31)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*31)/2)
W=(#Hor#*31)
H=(#Hor#*31)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*31)
LineLength=(#Hor#*31-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*31)

[MeterCircle32]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*32)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*32)/2)
W=(#Hor#*32)
H=(#Hor#*32)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*32)
LineLength=(#Hor#*32-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*32)

[MeterCircle33]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*33)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*33)/2)
W=(#Hor#*33)
H=(#Hor#*33)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*33)
LineLength=(#Hor#*33-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*33)

[MeterCircle34]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*34)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*34)/2)
W=(#Hor#*34)
H=(#Hor#*34)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*34)
LineLength=(#Hor#*34-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*34)

[MeterCircle35]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*35)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*35)/2)
W=(#Hor#*35)
H=(#Hor#*35)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*35)
LineLength=(#Hor#*35-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*35)

[MeterCircle36]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*36)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*36)/2)
W=(#Hor#*36)
H=(#Hor#*36)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*36)
LineLength=(#Hor#*36-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*36)

[MeterCircle37]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*37)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*37)/2)
W=(#Hor#*37)
H=(#Hor#*37)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*37)
LineLength=(#Hor#*37-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*37)

[MeterCircle38]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*38)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*38)/2)
W=(#Hor#*38)
H=(#Hor#*38)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*38)
LineLength=(#Hor#*38-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*38)

[MeterCircle39]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*39)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*39)/2)
W=(#Hor#*39)
H=(#Hor#*39)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*39)
LineLength=(#Hor#*39-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*39)

[MeterCircle40]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*40)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*40)/2)
W=(#Hor#*40)
H=(#Hor#*40)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*40)
LineLength=(#Hor#*40-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*40)

[MeterCircle41]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*41)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*41)/2)
W=(#Hor#*41)
H=(#Hor#*41)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*41)
LineLength=(#Hor#*41-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*41)

[MeterCircle42]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*42)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*42)/2)
W=(#Hor#*42)
H=(#Hor#*42)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*42)
LineLength=(#Hor#*42-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*42)

[MeterCircle43]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*43)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*43)/2)
W=(#Hor#*43)
H=(#Hor#*43)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*43)
LineLength=(#Hor#*43-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*43)

[MeterCircle44]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*44)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*44)/2)
W=(#Hor#*44)
H=(#Hor#*44)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*44)
LineLength=(#Hor#*44-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*44)

[MeterCircle45]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*45)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*45)/2)
W=(#Hor#*45)
H=(#Hor#*45)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*45)
LineLength=(#Hor#*45-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*45)

[MeterCircle46]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*46)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*46)/2)
W=(#Hor#*46)
H=(#Hor#*46)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*46)
LineLength=(#Hor#*46-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*46)

[MeterCircle47]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*47)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*47)/2)
W=(#Hor#*47)
H=(#Hor#*47)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*47)
LineLength=(#Hor#*47-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*47)

[MeterCircle48]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*48)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*48)/2)
W=(#Hor#*48)
H=(#Hor#*48)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*48)
LineLength=(#Hor#*48-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*48)

[MeterCircle49]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*49)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*49)/2)
W=(#Hor#*49)
H=(#Hor#*49)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*49)
LineLength=(#Hor#*49-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*49)

[MeterCircle50]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*50)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*50)/2)
W=(#Hor#*50)
H=(#Hor#*50)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*50)
LineLength=(#Hor#*50-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*50)

[MeterCircle51]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*51)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*51)/2)
W=(#Hor#*51)
H=(#Hor#*51)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*51)
LineLength=(#Hor#*51-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*51)

[MeterCircle52]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*52)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*52)/2)
W=(#Hor#*52)
H=(#Hor#*52)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*52)
LineLength=(#Hor#*52-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*52)

[MeterCircle53]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*53)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*53)/2)
W=(#Hor#*53)
H=(#Hor#*53)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*53)
LineLength=(#Hor#*53-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*53)

[MeterCircle54]
Meter=Roundline
X=((#SCREENAREAWIDTH#-#Hor#*54)/2)
Y=((#SCREENAREAHEIGHT#-#Hor#*54)/2)
W=(#Hor#*54)
H=(#Hor#*54)
StartAngle=4.712
RotationAngle=6.283
LineStart=(#Hor#*54)
LineLength=(#Hor#*54-1)
LineColor=#GridColor#
Solid=1
DynamicVariables=1
Hidden=(#ScreenAreaWidth#<#Hor#*54)

; ====================================================================================================================
; Diagonal Line Meters
;======================================================
;Author=ikarus1969
;Name=Draw lines
;Description=Drawing lines beyond only horizontal / vertical with images

; -------------
; some measures
; -------------
; to calculate the angle between the starting-point and the end-point
[Measure_GetAngle_ATAN1]
Measure=CALC
Formula=Atan((#LINE1_P2Y# - #LINE1_P1Y#) / (#LINE1_P2X# - #LINE1_P1X#))
DynamicVariables=1

; a "speciality" of the arcus-tangens-function:
;    you have to put it in the right quadrant to get the correct result
[Measure_GetAngle1]
Measure=CALC
Formula=(#LINE1_P2X# - #LINE1_P1X#) <= 0 ? Measure_GetAngle_ATAN1 + (PI * 1.5) : Measure_GetAngle_ATAN1 + (PI / 2)
DynamicVariables=1
MinValue=0
MaxValue=(2*PI)

[Measure_LineLength1]
Measure=CALC
Formula=Floor(Sqrt(((#LINE1_P1X#-#LINE1_P2X#)*(#LINE1_P1X#-#LINE1_P2X#))+((#LINE1_P1Y#-#LINE1_P2Y#)*(#LINE1_P1Y#-#LINE1_P2Y#))) + 0.5)
DynamicVariables=1

[Measure_GetAngle_ATAN2]
Measure=CALC
Formula=Atan((#LINE2_P2Y# - #LINE2_P1Y#) / (#LINE2_P2X# - #LINE2_P1X#))
DynamicVariables=1

; a "speciality" of the arcus-tangens-function:
;    you have to put it in the right quadrant to get the correct result
[Measure_GetAngle2]
Measure=CALC
Formula=(#LINE2_P2X# - #LINE2_P1X#) <= 0 ? Measure_GetAngle_ATAN2 + (PI * 1.5) : Measure_GetAngle_ATAN2 + (PI / 2)
DynamicVariables=1
MinValue=0
MaxValue=(2*PI)

[Measure_LineLength2]
Measure=CALC
Formula=Floor(Sqrt(((#LINE2_P1X#-#LINE2_P2X#)*(#LINE2_P1X#-#LINE2_P2X#))+((#LINE2_P1Y#-#LINE2_P2Y#)*(#LINE2_P1Y#-#LINE2_P2Y#))) + 0.5)
DynamicVariables=1

[MeterDiagonal1]
Meter=ROUNDLINE
MeasureName=Measure_GetAngle1
X=(#LINE1_P1X#-[Measure_LineLength1])
Y=(#LINE1_P1Y#-[Measure_LineLength1])
W=(2 * [Measure_LineLength1])
H=(2 * [Measure_LineLength1])
LineWidth=#LINE1_Width#
LineLength=([Measure_LineLength1])
LineStart=0
StartAngle=(-PI/2)
RotationAngle=(PI * 2)
LineColor=#CenterLineColor#
Solid=0
AntiAlias=1
DynamicVariables=1

[MeterDiagonal2]
Meter=ROUNDLINE
MeasureName=Measure_GetAngle2
X=(#LINE2_P1X#-[Measure_LineLength2])
Y=(#LINE2_P1Y#-[Measure_LineLength2])
W=(2 * [Measure_LineLength2])
H=(2 * [Measure_LineLength2])
LineWidth=#LINE2_Width#
LineLength=([Measure_LineLength2])
LineStart=0
StartAngle=(-PI/2)
RotationAngle=(PI * 2)
LineColor=#CenterLineColor#
Solid=0
AntiAlias=1
DynamicVariables=1

