import urllib.request
import json
from datetime import datetime
from pathlib import Path

OUTPUT_FILE = Path(r"C:\Users\yongw\claude-workplace\weather.txt")


def fetch_json(url):
    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
    with urllib.request.urlopen(req, timeout=15) as res:
        return json.loads(res.read().decode())


def pm25_grade(v):
    if v is None:
        return "알수없음"
    if v <= 15:
        return "좋음"
    elif v <= 35:
        return "보통"
    elif v <= 75:
        return "나쁨"
    else:
        return "매우나쁨"


def pm10_grade(v):
    if v is None:
        return "알수없음"
    if v <= 30:
        return "좋음"
    elif v <= 80:
        return "보통"
    elif v <= 150:
        return "나쁨"
    else:
        return "매우나쁨"


def main():
    now = datetime.now().strftime("%Y-%m-%d %H:%M")

    # 날씨 (wttr.in, API 키 불필요)
    try:
        data = fetch_json("https://wttr.in/Gangnam,Seoul?format=j1")
        c = data["current_condition"][0]
        temp       = c["temp_C"]
        feels_like = c["FeelsLikeC"]
        humidity   = c["humidity"]
        wind       = c["windspeedKmph"]
        desc       = c["weatherDesc"][0]["value"]
    except Exception as e:
        temp = feels_like = humidity = wind = "?"
        desc = f"날씨 조회 실패 ({e})"

    # 미세먼지 (WAQI demo 토큰, 가입 불필요)
    pm25 = pm10 = aqi = None
    try:
        data = fetch_json("https://api.waqi.info/feed/seoul/?token=demo")
        aqi  = data["data"]["aqi"]
        pm25 = data["data"]["iaqi"].get("pm25", {}).get("v")
        pm10 = data["data"]["iaqi"].get("pm10", {}).get("v")
    except Exception as e:
        aqi = f"조회 실패 ({e})"

    entry = f"""\
========================================
  서울 강남구 날씨 & 미세먼지
  조회 시각: {now}
========================================
[날씨]
  상태   : {desc}
  기온   : {temp}°C  (체감 {feels_like}°C)
  습도   : {humidity}%
  풍속   : {wind} km/h

[미세먼지]
  PM2.5  : {f"{pm25} ㎍/㎥" if pm25 is not None else "조회실패"}  → {pm25_grade(pm25)}
  PM10   : {f"{pm10} ㎍/㎥" if pm10 is not None else "조회실패"}  → {pm10_grade(pm10)}
  AQI    : {aqi}
========================================

"""

    # 최신 내용을 맨 위에 추가 (기존 기록 보존)
    existing = OUTPUT_FILE.read_text(encoding="utf-8") if OUTPUT_FILE.exists() else ""
    OUTPUT_FILE.write_text(entry + existing, encoding="utf-8")
    print(f"저장 완료: {OUTPUT_FILE}")


if __name__ == "__main__":
    main()
