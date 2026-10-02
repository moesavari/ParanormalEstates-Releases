# Paranormal Estates — Releases

Public binary distribution for **Paranormal Estates** games by Grand Mishap Studios.

> This repository contains compiled release packages and updater metadata only. Game source code and Unreal Engine project content live elsewhere and are not published here.

## Haunted Robberies update channel

The launcher reads `channels/haunted-robberies/stable.json`.

A channel stays disabled until a real packaged build has been published. The launcher must treat `enabled: false` as “no downloadable build available”.

## Publishing a build

1. Package the Windows build from Unreal Engine as usual.
2. Zip the **contents of the packaged build folder** so the game executable is at the expected root after extraction.
3. Create a GitHub Release with a tag such as `pehr-v0.4.0`.
4. Attach the ZIP using the name `PEHR-0.4.0-Windows.zip`.
5. Calculate the ZIP's SHA-256 hash.
6. Update `channels/haunted-robberies/stable.json` with the real version, asset URL, SHA-256, size, and release notes URL; set `enabled` to `true` only after the release asset exists.

The manifest is intentionally updated **last**. This prevents launchers from seeing an update before its package is actually downloadable.

## Versioning

Use PEHR's public game version, for example `0.4.0`, `0.4.5`, and eventually `1.0.0`. Release tags use `pehr-v<version>`.

## Security

The launcher must verify the downloaded ZIP against the manifest's SHA-256 before installing it. Never put a GitHub personal access token, source-repository credential, or other secret in a public manifest or launcher build.
