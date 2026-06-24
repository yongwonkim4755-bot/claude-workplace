# claude-workplace

토루크막토의 Claude Code 작업 공간입니다.

---

## 폴더 구조

```
claude-workplace/
│
├── CLAUDE.md            # Claude Code 행동 지침서 (규칙 모음)
├── SECURITY.md          # 🚨 키 노출 비상 매뉴얼
├── README.md            # 이 파일 — 폴더 안내
├── .env                 # 환경변수 (API 키 등) ← git 제외, 절대 공유 금지
├── .gitignore           # git에서 제외할 파일 목록
│
├── index.html           # 포트폴리오 페이지 (Vercel 배포 대상)
├── .vercelignore        # Vercel 배포 시 제외할 파일 목록
├── weather_fetch.py      # 날씨 데이터 가져오기 (Python)
├── weather_fetch.ps1      # 날씨 데이터 가져오기 (PowerShell)
├── weather.txt           # 날씨 데이터 저장 결과
│
├── docs/
│   ├── resume.pdf        # 이력서
│   └── sales.csv         # 매출 데이터
│
├── tasks/
│   ├── todo.md           # 오늘 할 일 체크리스트
│   └── progress.md       # 작업 기록 (append-only)
│
└── .claude/
    └── settings.local.json  # Claude Code 로컬 권한 설정 ← git 제외
```

---

## 파일별 역할

| 파일 | 역할 | 언제 열어보나 |
|------|------|--------------|
| `CLAUDE.md` | Claude Code 규칙·지침 | Claude가 자동으로 읽음 |
| `SECURITY.md` | 키 노출 비상 절차 | 보안 사고 발생 시 즉시 |
| `.env` | API 키, 비밀번호 등 | 키 교체·추가 시 |
| `weather_fetch.py` / `.ps1` | 날씨 API 호출 스크립트 | 날씨 데이터 갱신 시 |
| `docs/resume.pdf` | 이력서 | 지원·공유 시 |
| `docs/sales.csv` | 매출 데이터 | 매출 분석 시 |
| `tasks/todo.md` | 오늘 할 일 목록 | 작업 시작할 때 |
| `tasks/progress.md` | 완료한 작업 기록 | 작업 끝날 때 |

---

## 자주 쓰는 작업

### Claude Code 시작
```powershell
cd C:\Users\yongw\claude-workplace
claude
```

### 오라클 서버 접속
```powershell
ssh oracle-server
```

### 환경변수 파일 열기
```powershell
notepad C:\Users\yongw\claude-workplace\.env
```

### 할 일 목록 열기
```powershell
notepad C:\Users\yongw\claude-workplace\tasks\todo.md
```

### Vercel 배포
`index.html`이 포트폴리오 페이지입니다. `.vercelignore`로 이력서·매출 데이터 등 비공개 파일은 배포에서 제외되어 있습니다.
```powershell
vercel
```

---

## 보안 규칙 요약

- `.env` 파일은 절대 git에 올리지 않는다
- API 키는 코드에 직접 쓰지 않는다 — 항상 환경변수 참조
- 키 노출 의심 시 → `SECURITY.md` 순서대로 즉시 행동

---

*문의·피드백: Claude Code 에게 직접 말하거나 `CLAUDE.md` 규칙을 수정하세요.*
