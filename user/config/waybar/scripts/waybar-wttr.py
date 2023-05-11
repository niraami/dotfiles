#!/usr/bin/env python3

import json
import requests
import tempfile

from datetime import datetime
from pathlib import Path

# https://www.worldweatheronline.com/feed/wwoConditionCodes.txt
WEATHER_CODES = {
    '113': '󰖙',  # Clear/Sunny
    '116': '󰖕',  # Partly Cloudy
    '119': '󰖐',  # Cloudy
    '122': '󰖐',  # Overcast
    '143': '󰖑',  # Mist
    '176': '󰼳',  # Patchy rain nearby
    '179': '󰙿',  # Patchy snow nearby
    '182': '󰙿',  # Patchy sleet nearby
    '185': '󰙿',  # Patchy freezing drizzle nearby
    '200': '󰖓',  # Thundery outbreaks in nearby
    '227': '󰼶',  # Blowing snow
    '230': '󰼶',  # Blizzard
    '248': '󰖑',  # Fog
    '260': '󰼩',  # Freezing fog
    '263': '󰖗',  # Patchy light drizzle
    '266': '󰖗',  # Light drizzle
    '281': '󰙿',  # Freezing drizzle
    '284': '󰙿',  # Heavy freezing drizzle
    '293': '󰖗',  # Patchy light rain
    '296': '󰖗',  # Light rain
    '299': '󰖖',  # Moderate rain at times
    '302': '󰖖',  # Moderate rain
    '305': '󰖖',  # Heavy rain at times
    '308': '󰖖',  # Heavy rain
    '311': '󰙿',  # Light freezing rain
    '314': '󰙿',  # Moderate or Heavy freezing rain
    '317': '󰙿',  # Light sleet
    '320': '󰙿',  # Moderate or heavy sleet
    '323': '󰖘',  # Patchy light snow
    '326': '󰖘',  # Light snow
    '329': '󰼶',  # Patchy moderate snow
    '332': '󰼶',  # Moderate snow
    '335': '󰼶',  # Patchy heavy snow
    '338': '󰼶',  # Heavy snow
    '350': '󰖒',  # Ice pellets
    '353': '󰖗',  # Light rain shower
    '356': '󰖖',  # Moderate or heavy rain shower
    '359': '󰖖',  # Torrential rain shower
    '362': '󰖘',  # Light sleet showers
    '365': '󰼶',  # Moderate or heavy sleet showers
    '368': '󰖘',  # Light snow showers
    '371': '󰖒',  # Moderate or heavy snow showers
    '374': '󰖒',  # Light showers of ice pellets
    '377': '󰖒',  # Moderate or heavy showers of ice pellets
    '386': '󰙾',  # Patchy light rain in area with thunder
    '389': '󰙾',  # Moderate or heavy rain in area with thunder
    '392': '󰙾',  # Patchy light snow in area with thunder
    '395': '󰙾'  # Moderate or heavy snow in area with thunder
}


def main():
  weather = requests.get("https://wttr.in/?format=j1").json()

  current_condition = weather['current_condition'][0]
  weather_code = WEATHER_CODES[current_condition['weatherCode']]
  feels_like = current_condition['FeelsLikeC']

  # Create a string that Waybar can understand
  data = {
      'text': f"{weather_code} {feels_like}°C",
      'tooltip': getWeatherTooltip(weather)
  }

  fp = Path(tempfile.gettempdir()) / 'waybar-wttr.json'

  with fp.open('w') as fd:
    json.dump(data, fd)


def getWeatherTooltip(weather):
  current_condition = weather['current_condition'][0]

  desc = current_condition['weatherDesc'][0]['value']
  temp_c = current_condition['temp_C']
  feels_like = current_condition['FeelsLikeC']
  wind_speed = current_condition['windspeedKmph']
  humidity = current_condition['humidity']

  tooltip = (
      f"<b>{desc} {temp_c}°C</b>\n"
      f"Feels like: {feels_like}°C\n"
      f"Wind: {wind_speed}Km/h\n"
      f"Humidity: {humidity}%\n"
    )

  for i, day in enumerate(weather['weather']):
    date = day['date']
    max_temp = day['maxtempC']
    min_temp = day['mintempC']
    sunrise = day['astronomy'][0]['sunrise']
    sunset = day['astronomy'][0]['sunset']

    if i == 0:
      day_label = "Today, "
    elif i == 1:
      day_label = "Tomorrow, "
    else:
      day_label = ""

    tooltip += (
        f"\n<b>{day_label}{date}</b>\n"
        f"⬆️ {max_temp}° ⬇️ {min_temp}° "
        f"󰖜 {sunrise} 󰖛 {sunset}\n"
    )

    for hour in day['hourly']:
      if i == 0 and int(format_time(hour['time'])) < datetime.now().hour - 2:
        continue

      hour_time = format_time(hour['time'])
      hour_weather_code = WEATHER_CODES[hour['weatherCode']]
      hour_temp = format_temp(hour['FeelsLikeC'])
      hour_desc = hour['weatherDesc'][0]['value']
      hour_chances = format_chances(hour)

      tooltip += (
          f"{hour_time} {hour_weather_code} {hour_temp} "
          f"{hour_desc}, {hour_chances}\n"
      )

  return tooltip


def format_time(time):
  return time.replace("00", "").zfill(2)


def format_temp(temp):
  return f"{temp}°".ljust(3)


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
      conditions.append(chances[event] + " " + hour[event] + "%")
  return ", ".join(conditions)


if __name__ == "__main__":
  main()
