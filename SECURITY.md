# 🚨 보안 비상 매뉴얼

> 키 노출이 의심될 때 즉시 이 순서대로 행동하세요.
> **침착하게, 빠르게.**

---

## STEP 1 — 무엇이 노출됐는지 확인

| 서비스 | 키 형식 예시 | 위치 |
|--------|-------------|------|
| OpenRouter | `sk-or-v1-***` | `.env` → `OPENROUTER_API_KEY` |
| Oracle 서버 | SSH 개인키 파일 | `~/.ssh/oracle-server.key` |
| 기타 | 직접 확인 | `.env` 파일 전체 점검 |

---

## STEP 2 — 즉시 폐기

### OpenRouter API 키 폐기
1. https://openrouter.ai 로그인
2. **Keys** 메뉴 → 해당 키 옆 **Delete** 클릭
3. 새 키 발급 → 이름에 날짜 포함 (예: `key-20260529`)

### Oracle 서버 SSH 키 폐기
1. Oracle Cloud 콘솔 로그인
2. **Compute → Instances → 해당 인스턴스 → SSH Keys** 에서 노출 키 제거
3. 새 키페어 생성:
   ```powershell
   ssh-keygen -t ed25519 -f "$env:USERPROFILE\.ssh\oracle-server.key" -C "oracle-$(Get-Date -Format 'yyyyMMdd')"
   ```
4. 새 공개키를 Oracle 인스턴스에 등록

---

## STEP 3 — 환경변수 교체

```powershell
# .env 파일을 직접 열어 값 교체
notepad C:\Users\yongw\claude-workplace\.env
```

> ⚠️ `.env` 파일은 절대 git에 올리지 마세요.
> `.gitignore` 에 `.env` 가 있는지 반드시 확인.

---

## STEP 4 — 사용 이력 확인

### OpenRouter 사용 이력
1. https://openrouter.ai → **Activity** 탭
2. 노출 시점 이후 비정상 호출 여부 확인
3. 의심 호출 있으면 → OpenRouter 고객센터 신고

### Oracle 서버 접속 이력
```bash
# 서버 접속 후 실행
sudo last -n 30          # 최근 로그인 기록
sudo journalctl -u sshd --since "2026-05-29" # SSH 로그
```

---

## STEP 5 — 사후 조치 체크리스트

- [ ] 노출 키 폐기 완료
- [ ] 새 키 발급 완료
- [ ] `.env` 파일 업데이트 완료
- [ ] `.gitignore` 에 `.env` 등록 확인
- [ ] 비정상 사용 이력 없음 확인
- [ ] 필요 시 관련 서비스 비밀번호도 변경

---

## 긴급 연락처

- **OpenRouter 지원:** https://openrouter.ai (계정 내 Support)
- **Oracle Cloud 지원:** https://cloud.oracle.com (우측 상단 Help)

---

*이 매뉴얼은 `~/claude-workplace/SECURITY.md` 에 저장되어 있습니다.*
*키 노출 의심 시 Claude Code 에게 "키 노출 의심"이라고 말하면 이 매뉴얼을 안내받을 수 있습니다.*
