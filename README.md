# Il2CppDumper

**Version 6.7.47**

Updated version of [Il2CppDumper](https://github.com/Perfare/Il2CppDumper) by Perfare.
Extracts classes, methods, fields and strings from IL2CPP games: generates `dump.cs`, `DummyDll/*.dll`, IDA/Ghidra scripts.

## Changes compared to the original

- **Fixed NSO (Nintendo Switch) parser**: new SDKs store the MOD header pointer as an absolute virtual address (may reside in `.ro`) instead of an offset within `.text`. The original crashed with `Sequence contains no matching element` on such games.
- Targets **.NET 8.0 (net8.0)** only, single-file build (`PublishSingleFile`), ServerGC + TieredPGO enabled.
- Reliable headless/console-piped launch: `config.json` is created automatically if missing, correct exit codes (0/1), the "Press any key" pause no longer breaks redirected input.
- Hex input validation (ELF dump address, manual CodeRegistration/MetadataRegistration mode) instead of crashing on a typo.
- Fixed architecture selection in FAT Mach-O (invalid input no longer silently picks the wrong segment).
- Clear error message for unsupported metadata versions (versions 16–31 are supported).

## Usage

```
Il2CppDumper.exe <il2cpp-binary> <global-metadata.dat> <output-directory>
```

Example for Switch games (Eden/Yuzu/Ryujinx):

```bat
run_dump.bat
```

The batch script picks up `main` and `global-metadata.dat` from romfs and writes results to `output\`.

When launched without arguments on Windows, file-picker dialogs will appear.

## Output

| File | Description |
|---|---|
| `DummyDll/*.dll` | Stub assemblies — open in dnSpy/ILSpy |
| `dump.cs` | All classes / methods / fields / offsets as text |
| `script.json` | Script data for IDA/Ghidra (`ida.py`, `ghidra.py` from the exe directory) |
| `il2cpp.h` | C header with structs |
| `stringliteral.json` | String literals |

## Building

The project targets **.NET 8.0 (net8.0)**. Requires .NET SDK 8.0+:

```
dotnet publish src/Il2CppDumper -c Release -f net8.0 -p:PublishSingleFile=true -o publish
```

The resulting executable will be in `publish\`.

## Configuration

`config.json` next to the exe:

| Setting | Default | Description |
|---|---|---|
| `DumpMethod` | true | Dump methods |
| `DumpField` | true | Dump fields |
| `DumpProperty` | true | Dump properties |
| `DumpAttribute` | true | Dump attributes |
| `DumpFieldOffset` | true | Include field addresses |
| `DumpMethodOffset` | true | Include method addresses |
| `DumpTypeDefIndex` | true | Include type definition indices |
| `GenerateDummyDll` | true | Generate DummyDll assemblies |
| `GenerateStruct` | true | Generate script.json / il2cpp.h |
| `DummyDllAddToken` | true | Add metadata tokens to DummyDll |
| `RequireAnyKey` | true | Pause ("Press any key") at exit |
| `ForceIl2CppVersion` / `ForceVersion` | false / 16 | Force a specific IL2CPP metadata version |
| `ForceDump` | false | Treat the binary as a memory dump |
| `NoRedirectedPointer` | false | Don't resolve redirected pointers |

## License

MIT © Perfare 2016–2024. Modifications under the same license. See [LICENSE](LICENSE).
