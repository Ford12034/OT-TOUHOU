#!/usr/bin/env python3
"""Tier 1c decoy listener. One image, three behaviors, chosen by env vars.
  DECOY_MODE = banner | silent | http
  DECOY_PORT = port to listen on (default 502)
"""
import asyncio, os

MODE = os.environ.get("DECOY_MODE", "banner")
PORT = int(os.environ.get("DECOY_PORT", "502"))

async def banner(r, w):
    w.write(b"Modbus/TCP Gateway v2.1 ready\r\n")
    await w.drain()
    try:
        while await r.read(1024):
            pass
    finally:
        w.close()

async def silent(r, w):
    try:
        while await r.read(1024):
            pass
    finally:
        w.close()

async def http(r, w):
    await r.read(1024)
    body = b"<html><body>Plant status: OK</body></html>"
    w.write(b"HTTP/1.1 200 OK\r\nServer: nginx\r\nContent-Type: text/html\r\n"
            b"Content-Length: %d\r\nConnection: close\r\n\r\n" % len(body) + body)
    await w.drain()
    w.close()

HANDLERS = {"banner": banner, "silent": silent, "http": http}

async def main():
    if MODE not in HANDLERS:
        raise SystemExit(f"DECOY_MODE must be one of {list(HANDLERS)}")
    server = await asyncio.start_server(HANDLERS[MODE], "0.0.0.0", PORT)
    print(f"decoy mode={MODE} listening on {PORT}", flush=True)
    await server.serve_forever()

asyncio.run(main())
