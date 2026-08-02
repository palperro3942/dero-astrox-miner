# DERO AstroX Miner 1.1.0

![AstroX](logo/astrox.png)

Dominating the competition. A fast, transparent DERO AstroBWTv3 CPU miner for Windows x64. The optimized SA7 recipe is built into this production binary.

## Quick Start

Double-click `START_ASTROX.bat` for a guided setup, or run:

```powershell
.\dero-astrox-miner.exe -o stratum+tcp://pool.example:3333 --wallet YOUR_WALLET --password x --cpu-threads 0
```

Through a SOCKS5 proxy:

```powershell
.\dero-astrox-miner.exe -o stratum+tcp://pool.example:3333 --wallet YOUR_WALLET --password x --cpu-threads 0 --proxy socks5://127.0.0.1:1080
```

To report real hashrate to a Hansen33 Mod daemon:

```powershell
.\dero-astrox-miner.exe -o wss://node.example:10100 --wallet YOUR_WALLET.rig-name --cpu-threads 0 --report-realtime-hashrate
```

`--cpu-threads 0` selects an automatic thread count capped at 22. A positive value must not exceed the CPU's available logical threads.

## Options

| Option | Description |
| --- | --- |
| `-o <url>` | Primary daemon, `stratum+tcp://`, or `stratum+ssl://` endpoint |
| `-u`, `--wallet <wallet>` | User mining wallet; required |
| `-p`, `--password <password>` | Pool password; default `x` |
| `-t`, `--cpu-threads <count>` | Threads; `0` selects automatic mode |
| `-B <url>` | Optional backup endpoint of the same protocol type |
| `--proxy socks5://host:port` | Route daemon or Stratum traffic through SOCKS5 |
| `--report-realtime-hashrate` | Opt in to real H/s reports when a daemon advertises Hansen33 Mod |
| `--miner-tag <name>`, `--tag <name>` | Optional Hansen33 miner tag; defaults to `.rigname` |
| `-V` | Print version and exit |
| `-h` | Print help and exit |
| `--show-donation` | Print the fixed donation schedule and exit |

The long SRBMiner aliases above can be used in existing launch commands. Other unsupported options are reported as warnings and ignored, so harmless SRBMiner-specific switches do not abort startup. Required endpoint and wallet checks are never ignored.

SOCKS5 uses no proxy authentication and sends the destination hostname through the tunnel for remote DNS resolution. The same proxy is used for a configured backup endpoint. Use only a proxy you trust and are authorized to access.

Tor exposes SOCKS5 locally, commonly at `socks5://127.0.0.1:9050` for Tor Service or `socks5://127.0.0.1:9150` for Tor Browser. Remote DNS also permits a configured `.onion` endpoint. Tor latency and exit policies may reduce mining reliability.

Hansen33 reporting is disabled by default and is available only for daemon WebSocket mining. When explicitly enabled, AstroX waits for `hansen33_mod=true` from the daemon, then sends `wallet_address`, `miner_tag`, and the measured real hashrate every 10 seconds. The AstroMiner-compatible alias `-report-realtime-hashrate` is also accepted. Nothing is reported to official daemons, ordinary pools, or Stratum servers that do not advertise this extension.

With no arguments the binary only prints help. It never starts mining without an explicit endpoint and user wallet.

For pools that identify workers as `wallet.rigname`, pass the complete value to `-u` or `--wallet`. AstroX preserves the same `.rigname` suffix for both targets: `DEV_WALLET.rigname` during DEV and `USER_WALLET.rigname` during USER. The user's wallet dashboard is still expected to show that worker only after the first USER transition, plus any dashboard refresh delay.

## Keyboard Controls

- `p`: pause or resume mining
- `h`: show aggregate and per-thread hashrate
- `c`: show connection details
- `r`: show the top 10 accepted-miniblock efforts

## Transparent 2% Dev Fee

This release has a mandatory, visible 2% development fee. The first 2 minutes of each monotonic 100-minute active-mining cycle use the development wallet, followed by 98 minutes using the user wallet. Pausing freezes the schedule. A wallet transition drains queued/in-flight work, gives unacknowledged submissions a bounded response grace, and then reconnects for a fresh job without freeing TLS state from the reader thread.

The fee cannot be changed in the production binary. Its percentage and schedule are shown at startup and by `--show-donation`.

## Checksums

The Windows executable is stripped and statically linked with its non-system runtime libraries. It does not install a service, add persistence, hide itself, auto-start, or download executables.

```powershell
Get-FileHash .\dero-astrox-miner.exe -Algorithm SHA256
Get-Content .\dero-astrox-miner.exe.sha256
```

Compare the result with the checksum published alongside the release.
