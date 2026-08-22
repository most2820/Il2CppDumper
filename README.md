# Il2CppDumper (updated fork)

Обновлённая версия [Il2CppDumper](https://github.com/Perfare/Il2CppDumper) от Perfare.
Достаёт из il2cpp-игр классы, методы, поля и строки: генерирует `dump.cs`, `DummyDll/*.dll`, скрипты для IDA/Ghidra.

## Что изменено по сравнению с оригиналом

- **Исправлен парсер NSO (Nintendo Switch)**: новые SDK хранят указатель на MOD-заголовок как абсолютный виртуальный адрес (может лежать в `.ro`), а не смещение внутри `.text`. Оригинал на таких играх падал с `Sequence contains no matching element`.
- Таргет только **net8.0**, сборка в один файл (`PublishSingleFile`), включены ServerGC + TieredPGO.
- Устойчивый запуск без консоли/конфига: `config.json` создаётся автоматически при отсутствии, корректные коды выхода (0/1), пауза «Press any key» не ломает перенаправленный ввод.
- Валидация hex-ввода (адрес дампа ELF, ручной режим CodeRegistration/MetadataRegistration) вместо падения на опечатке.
- Исправлен выбор архитектуры в FAT Mach-O (неверный ввод больше не выбирает сегмент молча).
- Понятное сообщение о неподдерживаемой версии metadata (поддерживаются 16–31).

## Использование

```
Il2CppDumper.exe <il2cpp-бинарник> <global-metadata.dat> <папка вывода>
```

Пример для игры на Switch (Eden/Yuzu/Ryujinx):

```bat
run_dump.bat
```

Батник берёт `main` и `global-metadata.dat` из romfs и кладёт результат в `output\`.

Без аргументов на Windows откроются диалоги выбора файлов.

## Результат

| Файл | Описание |
|---|---|
| `DummyDll/*.dll` | Заглушки всех сборок — открываются в dnSpy/ILSpy |
| `dump.cs` | Все классы/методы/поля/оффсеты текстом |
| `script.json` | Скрипт-данные для IDA/Ghidra (`ida.py`, `ghidra.py` из папки exe) |
| `il2cpp.h` | C-заголовок со структурами |
| `stringliteral.json` | Строковые литералы |

## Сборка

Требуется .NET SDK 8.0+:

```
dotnet publish src/Il2CppDumper -c Release -f net8.0 -p:PublishSingleFile=true -o publish
```

Готовый exe появится в `publish\`.

## Настройки

`config.json` рядом с exe:

| Параметр | По умолчанию | Описание |
|---|---|---|
| `GenerateDummyDll` | true | Генерировать DummyDll |
| `GenerateStruct` | true | Генерировать script.json / il2cpp.h |
| `DumpMethodOffset` | true | Показывать адреса методов |
| `ForceIl2CppVersion` / `ForceVersion` | false / 16 | Принудительная версия il2cpp |
| `ForceDump` | false | Считать бинарник сдампленным из памяти |

## Лицензия

MIT © Perfare 2016–2024. Изменения — по той же лицензии. См. [LICENSE](LICENSE).
