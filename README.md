# Eternity

> Пульт управления для обхода блокировок на Windows: DPI-обход, DNS, Telegram-прокси и WARP в одном красивом терминале.

![Windows](https://img.shields.io/badge/Windows-10%20%7C%2011-0078D6?logo=windows)
![PowerShell](https://img.shields.io/badge/PowerShell-5.1-5391FE?logo=powershell&logoColor=white)
![Version](https://img.shields.io/badge/version-1.0.0-ffa6cc)

Eternity не изобретает обход блокировок заново. Он берёт проверенные open-source инструменты (GoodbyeDPI, zapret, TG WS Proxy, Cloudflare WARP) и собирает их под одним интерфейсом: статус всех модулей на экране, включение и выключение одной клавишей, автоподбор рабочих настроек и кнопка «вернуть всё как было».

---

## Возможности

| Модуль | Что делает |
|---|---|
| **DPI-обход** | Запускает [GoodbyeDPI](https://github.com/ValdikSS/GoodbyeDPI) или [zapret](https://github.com/Flowseal/zapret-discord-youtube) (winws). Обходит блокировки по SNI (YouTube, Discord и др.) |
| **Автоподбор стратегии** | Сам перебирает стратегии zapret и оставляет первую, при которой открывается YouTube |
| **DNS** | Cloudflare, Bezmezhau, Xbox DNS, Comss.one, AdGuard. DoH там, где он поддерживается |
| **Автоподбор DNS** | Проверяет ChatGPT, YouTube, Discord, Instagram, Telegram, GitHub у каждого DNS и предлагает лучший |
| **TG WS Proxy** | Локальный прокси для Telegram Desktop ([Flowseal/tg-ws-proxy](https://github.com/Flowseal/tg-ws-proxy)), сам формирует ссылку для подключения |
| **Cloudflare WARP** | Официальный клиент через `warp-cli`. Взаимоисключается с DPI-обходом |
| **Датчики** | Температуры и нагрузка CPU/GPU/дисков прямо в статистике (CPU через [LibreHardwareMonitor](https://github.com/LibreHardwareMonitor/LibreHardwareMonitor)) |
| **Автозапуск** | При входе в Windows поднимает то, что было включено, без окна UAC |
| **Режим терминала** | Тот же промпт принимает обычные команды PowerShell, с автодополнением (PSReadLine) и историей |
| **Темы** | Bear, Eyes, Elf, Redhead: своя палитра, фон и рисунок |
| **Полный сброс** | Одна клавиша возвращает DNS, выгружает драйверы, убирает автозапуск и (по желанию) скачанные файлы |
| **Автообновление** | Проверяет новую версию на GitHub при запуске и обновляется по подтверждению |

## Скриншоты

<img width="1563" height="1029" alt="image" src="https://github.com/user-attachments/assets/cf28e696-3ec2-4d6a-82bb-c9f0e2e734bd" />
<img width="2011" height="1225" alt="image" src="https://github.com/user-attachments/assets/23a74eba-5e35-401e-8b06-fa6f84badbc0" />



## Требования

- Windows 10 / 11 (для системного DoH желательно Windows 11 или Win10 22H2+)
- Windows PowerShell 5.1 (есть в системе)
- Права администратора (запрашиваются сами)
- Рекомендуется [Windows Terminal](https://aka.ms/terminal) — прозрачность, тема и размер окна работают в нём

## Установка и запуск

1. Скачайте репозиторий (`Code → Download ZIP`) или последний релиз и распакуйте **в папку без кириллицы по возможности**.
2. Запустите `Eternity.bat`. Подтвердите запрос UAC.
3. При первом запуске скрипт предложит установить датчики температур (можно отказаться).

Профиль Windows Terminal `Eternity` с темой и прозрачностью можно создать вручную (см. раздел «Windows Terminal» ниже); без него программа откроется в стандартном окне.

## Меню

| Клавиша | Действие |
|---|---|
| `1` | DPI-обход вкл/выкл |
| `2` | DNS вкл/выкл (последний выбранный провайдер) |
| `3` | TG WS Proxy вкл/выкл |
| `4` | Cloudflare WARP вкл/выкл |
| `5` | Автоподбор стратегии DPI (zapret) |
| `6` | Движок DPI: goodbyedpi / zapret |
| `7` | Режим goodbyedpi: -5 / -9 |
| `8` | Автозапуск вкл/выкл |
| `9` | Тест сайтов (DNS или SNI?) |
| `D` | Выбрать DNS |
| `A` | Автоподбор DNS |
| `T` | Добавить прокси в Telegram |
| `U` | Обновить компоненты |
| `S` | Сменить тему |
| `M` | Режим терминала (выход: `menu`) |
| `H` | Датчики (LibreHardwareMonitor) вкл/выкл |
| `G` | Проверить обновления |
| `R` | **Полный сброс** |
| `0` | Выход |

## Как это устроено

```
Eternity.bat       запуск
Eternity.ps1       вся программа
eternity.json      настройки (тема, движок, выбранный DNS ...) — создаётся сам
C:\ProgramData\Eternity\
    goodbyedpi\    скачанный GoodbyeDPI
    zapret\        скачанный zapret (Flowseal)
    tgws\          TG WS Proxy
    lhm\           LibreHardwareMonitor
```

Все скачиваемые компоненты лежат в `C:\ProgramData\Eternity` — путь без кириллицы, нужен zapret.

## Обновления

- При запуске (не чаще раза в 30 минут) проверяется последний релиз `Miha1ych/Eternity`; если релизов нет — файл `VERSION` в ветке `main`.
- Новый `Eternity.ps1` перед заменой проверяется парсером PowerShell; старая версия сохраняется как `Eternity.ps1.bak`.
- Отключить проверку: в `eternity.json` поставить `"update_check": false`.
- Вручную: пункт `G`.

## Безопасность и ограничения

- Eternity запускается **от администратора**, потому что WinDivert и смена DNS требуют прав. Код открыт, читайте его перед запуском.
- **Автообновление скачивает и исполняет код из этого репозитория.** Включайте его, только если доверяете источнику.
- Антивирус может ругаться на **WinDivert** (драйвер GoodbyeDPI/zapret) и на драйвер LibreHardwareMonitor. Это штатные драйверы этих проектов; при необходимости добавьте `C:\ProgramData\Eternity` в исключения.
- **DNS Bezmezhau и Xbox DNS** — обычный (нешифрованный) DNS сторонних операторов. Оператор видит запросы и может подменять ответы. Для чувствительных вещей выбирайте Cloudflare / AdGuard.
- DPI-обход работает против блокировок по SNI, но **не поможет** при блокировке по IP — тогда нужен WARP или VPN. Стратегии со временем устаревают, подбор нужно повторять.
- Температуру CPU Windows сама не отдаёт, для неё нужен драйвер LibreHardwareMonitor.
- В режиме терминала команды исполняются с правами администратора.
- Проект не связан с авторами GoodbyeDPI, zapret, tg-ws-proxy, LibreHardwareMonitor и Cloudflare. Используйте на свой риск и в соответствии с законодательством вашей страны.

## Если что-то сломалось

Нажмите **`R`** — полный сброс: остановит все модули, вернёт DNS на автоматический, выгрузит драйверы WinDivert, уберёт автозапуск. Если интернета нет вообще, в PowerShell от администратора:

```powershell
Get-Process goodbyedpi,winws -ErrorAction SilentlyContinue | Stop-Process -Force
Get-NetAdapter | ForEach-Object { Set-DnsClientServerAddress -InterfaceIndex $_.ifIndex -ResetServerAddresses }
ipconfig /flushdns
```

## Windows Terminal

Для прозрачности и цветовой схемы добавьте в `settings.json` Windows Terminal профиль с именем `Eternity` (`useAcrylic: true`, `opacity: 60`, `commandline: powershell.exe`) — Eternity сам запускается через `wt -p Eternity` и подбирает размер окна под выбранную тему.

## Благодарности

- [ValdikSS/GoodbyeDPI](https://github.com/ValdikSS/GoodbyeDPI)
- [Flowseal/zapret-discord-youtube](https://github.com/Flowseal/zapret-discord-youtube) и [bol-van/zapret](https://github.com/bol-van/zapret)
- [Flowseal/tg-ws-proxy](https://github.com/Flowseal/tg-ws-proxy)
- [LibreHardwareMonitor](https://github.com/LibreHardwareMonitor/LibreHardwareMonitor)
- [Cloudflare WARP](https://one.one.one.one/)


Батник использует весь софт именно этих ребят, обязательно перейдите и поставьте звездочку! 
