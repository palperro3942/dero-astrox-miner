# DERO AstroX Miner

Dominating the competition. A fast, transparent DERO AstroBWTv3 CPU miner for Windows x64. This release ships with its optimized algorithm configuration built in, so normal users do not need tuning flags or profiles.

## Quick Start

For unattended restarts, edit `rpc_mine.bat` and set your wallet, node or pool URL, password, and thread count. The template refuses to start until a wallet is explicitly configured.

Or use the guided launcher:

Double-click `START_ASTROX.bat` for a guided start. It asks for:

- primary node or pool URL
- your DERO wallet
- pool password (`x` is the usual default)
- thread count (up to `22`, limited by the CPU)
- optional backup URL

The launcher does not save credentials or settings. It displays the selected configuration and asks for confirmation before mining starts.

You can also start the miner directly:

```powershell
.\dero-astrox-miner.exe -o 127.0.0.1:10100 -u dero1... -p x -t 22
```

With a backup endpoint:

```powershell
.\dero-astrox-miner.exe -o primary-node:10100 -B backup-node:10100 -u dero1... -p x -t 22
```

## Command Line

| Option | Description |
| --- | --- |
| `-o <url>` | Primary DERO daemon or `stratum+tcp://` / `stratum+ssl://` pool |
| `-u <wallet>` | Your mining wallet; required |
| `-p <password>` | Pool password; defaults to `x` |
| `-t <threads>` | Mining threads; defaults to up to `22`, limited by the CPU's logical threads |
| `-B <url>` | Optional backup endpoint of the same protocol type |
| `-V` | Print version and exit |
| `-h` | Print help and exit |
| `--show-donation` | Print the donation schedule and exit |

With no arguments, the executable only prints help. Mining never starts without explicit `-o` and `-u` values.
An explicit `-t` value above the available logical CPU count exits with `invalid CPU threads` before connecting.

## Keyboard Controls

- `p`: pause or resume mining
- `h`: show aggregate hashrate and hashrate for every thread
- `c`: show current connection details
- `r`: show the top 10 efforts for accepted miniblocks; it stays silent until one is accepted

The normal work line remains compact and shows the active endpoint, difficulty, height, total hashrate, accepted, rejected, and stale counts. Detailed reports are printed only when requested with a hotkey.

## Transparent 2% Dev Fee

The previously planned ~~10%~~ rate has been replaced by a mandatory, visible `2%` development fee. The first 2 minutes of each monotonic 100-minute cycle mine to the development wallet; the following 98 minutes mine to the user wallet. Only active mining time advances this cycle: pressing `p` freezes the donation clock until mining is resumed. This release does not expose an option to change or disable it.

Development wallet:

```text
dero1qype0r5uv28n4v0z9ejfsuk4umu65c6tlv2phd4rdj9h4rh6vt6psqqx7a6es
```

The startup banner shows the percentage and schedule without printing the development wallet. `--show-donation` provides the full transparent schedule. A wallet transition waits until workers are between hashes and there are no queued, in-flight, or pending shares. It then requests a fresh job through the normal scheduler generation path.

## Binary and Checksums

The release executable is a stripped PE32+ AMD64 binary statically linked with its non-system runtime libraries. It only imports Windows system DLLs. It does not install a service, add persistence, hide itself, auto-start, or download executables.

Verify the downloaded binary in PowerShell:

```powershell
Get-FileHash .\dero-astrox-miner.exe -Algorithm SHA256
Get-Content .\dero-astrox-miner.exe.sha256
```

The release also includes `SHA256SUMS.txt` and a `.sha256` sidecar for the ZIP archive. Always compare checksums with the values published alongside the GitHub release.

Building a highly optimized miner is an extremely complicated and time-consuming task. Please consider making a donation or leaving a star if this project is useful to you.

```text
BTC: bc1qhf0lqm06d7qdltfnxuy6c6p49nr7wt2fm43vfw
DERO: dero1qype0r5uv28n4v0z9ejfsuk4umu65c6tlv2phd4rdj9h4rh6vt6psqqx7a6es
```
