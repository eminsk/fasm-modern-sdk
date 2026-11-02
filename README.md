# ⚡ FASM Modern SDK

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platforms-Windows%20%7C%20Linux%20%7C%20macOS-informational.svg)](https://github.com/eminsk/fasm-modern-sdk)
[![FASM Core](https://img.shields.io/badge/FASM%20Core-v1.73.35%20%2B%20FASM%202%20(fasmg)-orange.svg)](https://flatassembler.net/)
[![Pure x86--64](https://img.shields.io/badge/Binary%20Size-~3KB%20--%20189KB%20(No%20CRT)-emerald.svg)](https://github.com/eminsk/fasm-modern-sdk)

**FASM Modern SDK** — это современная модульная платформа и расширенная стандартная библиотека для ассемблера **Flat Assembler (FASM)** с поддержкой Windows, Linux и macOS. Она превращает FASM в мощный инструмент для создания высокопроизводительных нативных приложений XXI века с ультрасовременным интерфейсом (**Fluent Dark UI**), сетевым стеком HTTPS, разбором JSON и интеграцией с Python (`pyfasm64`).

---

## 🌟 Возможности (Features)

1. **⚡ Самокомпилируемое ядро (Self-Compiling Engine)**:
   - Включает **FASM 1.73.35** и **FASM 2 (fasmg)**.
   - Компилирует сам себя за **0.1 секунды** без сторонних утилит и компиляторов C.
   - Исходный код подсистем: `win32`, `linux/x64`, `libc` (macOS), `dos`.

2. **🎨 Fluent Dark UI Engine (`include/ui_fluent.inc`)**:
   - Аппаратная темная тема Windows 10/11 (`DwmSetWindowAttribute`).
   - Скругленные кнопки (`BS_OWNERDRAW` + GDI `RoundRect`) с динамическими состояниями Hover и Active.
   - Сегментированные вкладки (**Pill Tabs**) с подсветкой активного раздела.
   - Кастомные карточки списков с бейджами ответов (`[✓ 1 ans]`), счетчиками просмотров (`1.1k views`), рейтингом и тегами.
   - Контейнеры блоков кода с моноширинным шрифтом, бейджем языка (`Python`) и кнопкой копирования.

3. **🌐 Нативный сетевой стек HTTPS/TLS (`include/net_https.inc`)**:
   - Прямой вызов WinINet HTTPS с протоколами TLS 1.2 / TLS 1.3.
   - Автоматическая аппаратная распаковка `gzip` и `deflate`.
   - Поддержка REST API (Stack Overflow, GitHub, Telegram, пользовательские микросервисы).

4. **⚡ Zero-Allocation JSON Parser (`include/json_fast.inc`)**:
   - Извлечение строковых значений (`JsonGetStr`) и чисел (`JsonGetInt`) без аллокаций памяти.
   - Декодирование экранированных последовательностей и HTML-сущностей.
   - Выполнение запросов за доли микросекунды.

5. **📦 Нативные структуры данных Python (`include/data_structures.inc`)**:
   - **Хэш-таблицы (Dictionary)**: 64-битный хэш FNV-1a, $O(1)$ поиск, добавление, удаление и размер.
   - **Динамические списки (List)**: `append`, `pop`, `len`.
   - **Быстрые строковые процедуры**: `lower`, `upper`, `strip`, `startswith`, `endswith`, `contains`, `concat`.

6. **🐍 Интеграция с компилятором `pyfasm64`**:
   - Любой проект на Python (`CustomTkinter`, `requests`, `beautifulsoup4`, `darkdetect`) может компилироваться в машинный код FASM с использованием этих модулей.

---

## 📁 Структура проекта (Repository Structure)

```text
fasm-modern-sdk/
├── bin/                          # Готовые бинарники компилятора
│   ├── fasm.exe                  # Windows x86-64 (118 KB)
│   ├── fasm.linux                # Linux x86_64 ELF
│   ├── fasm.darwin               # macOS x86_64 Mach-O
│   ├── fasmg.exe                 # FASM 2 (fasmg engine)
│   └── fasmg.x64                 # FASM 2 для Linux
├── include/                      # Современная библиотека FASM Modern SDK
│   ├── ui_fluent.inc             # Fluent Dark UI компоненты (кнопки, табы, карточки)
│   ├── net_https.inc             # Сетевой клиент HTTPS/TLS
│   ├── json_fast.inc             # Zero-allocation парсер JSON
│   ├── syntax_color.inc          # Подсветка синтаксиса (Python, C++, Rust, JS)
│   ├── data_structures.inc       # Dict (FNV-1a), List, String методы
│   ├── core/                     # Базовые заголовки Win64 (win64a.inc)
│   └── fasmg/                    # Заголовки FASM 2
├── src/                          # Исходный код FASM (самокомпиляция)
│   ├── fasm1/                    # Исходники FASM 1.73.35 (WIN32, LINUX/X64, LIBC)
│   └── fasmg/                    # Исходники FASM 2 (CALM engine)
├── examples/
│   ├── StackOverflowSearchPro/   # Эталонный настольный клиент (~189 KB, чистый FASM)
│   └── MinimalFluentApp/         # Минимальное стартовое приложение (~3 KB)
├── .github/workflows/
│   └── release.yml               # CI/CD: автосборка и публикация релизов Windows/Linux/Mac
├── build.bat                     # Скрипт сборки под Windows
├── build.sh                      # Скрипт сборки под Linux / macOS
└── README.md
```

---

## 🚀 Быстрый старт (Quick Start)

### Сборка и проверка всей платформы (Windows):
```cmd
build.bat
```

### Сборка эталонного приложения Stack Overflow Search Pro:
```cmd
cd examples\StackOverflowSearchPro
build.bat
```
В результате создается автономный файл `StackOverflowSearch.exe` размером **189 КБ**, не требующий Python, .NET или C++ Runtime.

---

## 📜 Лицензия (License)

Проект распространяется под открытой лицензией **MIT License**. Ядро FASM создано Tomasz Grysztar (Flat Assembler BSD-style license).
