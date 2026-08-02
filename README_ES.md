# DERO AstroX Miner 1.1.0

![AstroX](logo/astrox.png)

Dominando a la competencia. Minero CPU transparente y optimizado para DERO AstroBWTv3 en Windows x64. La receta SA7 validada viene integrada en el binario de produccion.

## Inicio rapido

Ejecuta `START_ASTROX.bat` para una configuracion guiada, o usa:

```powershell
.\dero-astrox-miner.exe -o stratum+tcp://pool.example:3333 --wallet YOUR_WALLET --password x --cpu-threads 0
```

Mediante un proxy SOCKS5:

```powershell
.\dero-astrox-miner.exe -o stratum+tcp://pool.example:3333 --wallet YOUR_WALLET --password x --cpu-threads 0 --proxy socks5://127.0.0.1:1080
```

Para reportar hashrate real a un daemon Hansen33 Mod:

```powershell
.\dero-astrox-miner.exe -o wss://nodo.example:10100 --wallet YOUR_WALLET.rig-name --cpu-threads 0 --report-realtime-hashrate
```

`--cpu-threads 0` selecciona automaticamente hasta 22 hilos. Un valor positivo no puede superar los hilos logicos disponibles en el CPU.

## Opciones

| Opcion | Descripcion |
| --- | --- |
| `-o <url>` | Daemon principal o pool `stratum+tcp://` / `stratum+ssl://` |
| `-u`, `--wallet <wallet>` | Wallet de mineria del usuario; obligatoria |
| `-p`, `--password <password>` | Password del pool; por defecto `x` |
| `-t`, `--cpu-threads <count>` | Hilos; `0` selecciona modo automatico |
| `-B <url>` | Endpoint de respaldo opcional del mismo protocolo |
| `--proxy socks5://host:puerto` | Envia daemon o Stratum mediante SOCKS5 |
| `--report-realtime-hashrate` | Activa reportes de H/s reales cuando el daemon anuncia Hansen33 Mod |
| `--miner-tag <nombre>`, `--tag <nombre>` | Tag Hansen33 opcional; usa `.rigname` por defecto |
| `-V` | Muestra la version y termina |
| `-h` | Muestra ayuda y termina |
| `--show-donation` | Muestra el calendario fijo de donacion y termina |

Los aliases largos anteriores permiten reutilizar comandos de SRBMiner. Otras opciones no compatibles muestran una advertencia y se ignoran, de modo que switches inofensivos de SRBMiner no interrumpan el inicio. La URL principal y la wallet siempre son obligatorias.

SOCKS5 no usa autenticacion de proxy y envia el nombre del destino por el tunel para resolver DNS remotamente. El endpoint de respaldo usa el mismo proxy. Utiliza solamente un proxy confiable y autorizado.

Tor expone SOCKS5 localmente, normalmente en `socks5://127.0.0.1:9050` para Tor Service o `socks5://127.0.0.1:9150` para Tor Browser. El DNS remoto tambien permite un endpoint `.onion`. La latencia y politicas de salida de Tor pueden reducir la estabilidad de mineria.

El reporte Hansen33 esta desactivado por defecto y funciona solo con mineria WebSocket hacia daemon. Cuando se activa explicitamente, AstroX espera `hansen33_mod=true` y envia `wallet_address`, `miner_tag` y el hashrate real medido cada 10 segundos. Tambien acepta el alias de AstroMiner `-report-realtime-hashrate`. No envia esta telemetria a daemons oficiales, pools normales ni servidores Stratum que no anuncien la extension.

Sin argumentos el binario solo muestra ayuda. Nunca inicia mineria sin endpoint y wallet proporcionados explicitamente.

En pools que identifican workers como `wallet.rigname`, entrega el valor completo a `-u` o `--wallet`. AstroX conserva el mismo sufijo `.rigname` en ambos targets: `DEV_WALLET.rigname` durante DEV y `USER_WALLET.rigname` durante USER. El panel de la wallet del usuario mostrara ese worker despues de la primera transicion a USER y del tiempo de actualizacion del panel.

## Teclas

- `p`: pausar o continuar
- `h`: hashrate total y por hilo
- `c`: detalles de conexion
- `r`: top 10 de esfuerzos de miniblocks aceptados

## Dev fee transparente de 2%

La version tiene una comision obligatoria y visible de 2%. Los primeros 2 minutos de cada ciclo monotono de 100 minutos de mineria activa usan la wallet de desarrollo; los 98 minutos siguientes usan la wallet del usuario. Pausar congela el reloj. El cambio de wallet drena el trabajo en cola/en vuelo, concede una espera acotada a envios sin ACK y reconecta para solicitar trabajo nuevo sin liberar TLS desde el hilo lector.

La comision no se puede modificar en el binario de produccion. El porcentaje y calendario aparecen al iniciar y con `--show-donation`.

## Checksums

El ejecutable Windows esta limpio de simbolos y enlazado estaticamente con sus runtimes no pertenecientes al sistema. No instala servicios, no agrega persistencia, no se oculta, no inicia automaticamente y no descarga ejecutables.

```powershell
Get-FileHash .\dero-astrox-miner.exe -Algorithm SHA256
Get-Content .\dero-astrox-miner.exe.sha256
```

Compara el resultado con el checksum publicado junto al release.
