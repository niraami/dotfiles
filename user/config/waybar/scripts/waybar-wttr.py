#!/usr/bin/env python3

import json
import requests
from datetime import datetime

# https://www.worldweatheronline.com/feed/wwoConditionCodes.txt
# 395	Moderate or heavy snow in area with thunder
# 392	Patchy light snow in area with thunder
# 389	Moderate or heavy rain in area with thunder
# 386	Patchy light rain in area with thunder
# 377	Moderate or heavy showers of ice pellets
# 374	Light showers of ice pellets
# 371	Moderate or heavy snow showers
# 368	Light snow showers
# 365	Moderate or heavy sleet showers
# 362	Light sleet showers
# 359	Torrential rain shower
# 356	Moderate or heavy rain shower
# 353	Light rain shower
# 350	Ice pellets
# 338	Heavy snow
# 335	Patchy heavy snow
# 332	Moderate snow
# 329	Patchy moderate snow
# 326	Light snow
# 323	Patchy light snow
# 320	Moderate or heavy sleet
# 317	Light sleet
# 314	Moderate or Heavy freezing rain
# 311	Light freezing rain
# 308	Heavy rain
# 305	Heavy rain at times
# 302	Moderate rain
# 299	Moderate rain at times
# 296	Light rain
# 293	Patchy light rain
# 284	Heavy freezing drizzle
# 281	Freezing drizzle
# 266	Light drizzle
# 263	Patchy light drizzle
# 260	Freezing fog
# 248	Fog
# 230	Blizzard
# 227	Blowing snow
# 200	Thundery outbreaks in nearby
# 185	Patchy freezing drizzle nearby
# 182	Patchy sleet nearby
# 179	Patchy snow nearby
# 176	Patchy rain nearby
# 143	Mist
# 122	Overcast
# 119	Cloudy
# 116	Partly Cloudy
# 113	Clear/Sunny

WEATHER_CODES = {
    '113': '󰖙',
    '116': '󰖕',
    '119': '󰖐',
    '122': '󰖐',
    '143': '󰖑',
    '176': '󰼳',
    '179': '󰙿',
    '182': '󰙿',
    '185': '󰙿',
    '200': '󰖓',
    '227': '󰼶',
    '230': '󰼶',
    '248': '󰖑',
    '260': '󰼩',
    '263': '󰖗',
    '266': '󰖗',
    '281': '󰙿',
    '284': '󰙿',
    '293': '󰖗',
    '296': '󰖗',
    '299': '󰖖',
    '302': '󰖖',
    '305': '󰖖',
    '308': '󰖖',
    '311': '󰙿',
    '314': '󰙿',
    '317': '󰙿',
    '320': '󰙿',
    '323': '󰖘',
    '326': '󰖘',
    '329': '󰼶',
    '332': '󰼶',
    '335': '󰼶',
    '338': '󰼶',
    '350': '󰖒',
    '353': '󰖗',
    '356': '󰖖',
    '359': '󰖖',
    '362': '󰖘',
    '365': '󰼶',
    '368': '󰖘',
    '371': '󰖒',
    '374': '󰖒',
    '377': '󰖒',
    '386': '󰙾',
    '389': '󰙾',
    '392': '󰙾',
    '395': '󰙾'
}

data = {}


weather = requests.get("https://wttr.in/?format=j1").json()


def format_time(time):
    return time.replace("00", "").zfill(2)


def format_temp(temp):
    return (hour['FeelsLikeC']+"°").ljust(3)


def format_chances(hour):
    chances = {
        "chanceoffog": "Fog",
        "chanceoffrost": "Frost",
        "chanceofovercast": "Overcast",
        "chanceofrain": "Rain",
        "chanceofsnow": "Snow",
        "chanceofsunshine": "Sunshine",
        "chanceofthunder": "Thunder",
        "chanceofwindy": "Wind"
    }

    conditions = []
    for event in chances.keys():
        if int(hour[event]) > 0:
            conditions.append(chances[event]+" "+hour[event]+"%")
    return ", ".join(conditions)


data['text'] = WEATHER_CODES[weather['current_condition'][0]['weatherCode']] + \
    " "+weather['current_condition'][0]['FeelsLikeC']+"°C"

data['tooltip'] = f"<b>{weather['current_condition'][0]['weatherDesc'][0]['value']} {weather['current_condition'][0]['temp_C']}°C</b>\n"
data['tooltip'] += f"Feels like: {weather['current_condition'][0]['FeelsLikeC']}°C\n"
data['tooltip'] += f"Wind: {weather['current_condition'][0]['windspeedKmph']}Km/h\n"
data['tooltip'] += f"Humidity: {weather['current_condition'][0]['humidity']}%\n"
for i, day in enumerate(weather['weather']):
    data['tooltip'] += f"\n<b>"
    if i == 0:
        data['tooltip'] += "Today, "
    if i == 1:
        data['tooltip'] += "Tomorrow, "
    data['tooltip'] += f"{day['date']}</b>\n"
    data['tooltip'] += f"⬆️ {day['maxtempC']}° ⬇️ {day['mintempC']}° "
    data['tooltip'] += f"󰖜 {day['astronomy'][0]['sunrise']} 󰖛 {day['astronomy'][0]['sunset']}\n"
    for hour in day['hourly']:
        if i == 0:
            if int(format_time(hour['time'])) < datetime.now().hour-2:
                continue
        data['tooltip'] += f"{format_time(hour['time'])} {WEATHER_CODES[hour['weatherCode']]} {format_temp(hour['FeelsLikeC'])} {hour['weatherDesc'][0]['value']}, {format_chances(hour)}\n"


print(json.dumps(data))
