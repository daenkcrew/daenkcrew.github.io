---
layout: post
title: Dengerin Spotify Tanpa Iklan Di PC (No crack, no premium)
category: id
tags: trick tip
---
Inilah cara paling mudah dengerin spotify tanpa terganggu iklan. Tanpa instal software tambahan, tanpa upgrade ke premium, dan tanpa bajak akun punya orang lain.

> **Disclaimer:** cara ini tidak mengaktifkan fitur premium yang lain seperti offline mode, high quality streaming, dll.

## Daftar host list yang akan di blok

- Buka web browser dan akses `https://github.com/zackad/dotfiles/blob/master/hosts.d/ads_spotify.conf` atau [klik disini][hostfile-url]
- Copy isi file tersebut (kurang lebih seperti dibawah ini)

```
# BLock ads host for spotify
# host list taken from https://www.reddit.com/r/Piracy/comments/4kn6rq/comprehensive_guide_to_blocking_ads_on_spotify/
127.0.0.1       adclick.g.doublecklick.net
127.0.0.1       adeventtracker.spotify.com
127.0.0.1       ads-fa.spotify.com
127.0.0.1       analytics.spotify.com
127.0.0.1       audio2.spotify.com
127.0.0.1       b.scorecardresearch.com
127.0.0.1       bounceexchange.com
127.0.0.1       bs.serving-sys.com
127.0.0.1       content.bitsontherun.com
127.0.0.1       core.insightexpressai.com
127.0.0.1       crashdump.spotify.com
127.0.0.1       d2gi7ultltnc2u.cloudfront.net
127.0.0.1       d3rt1990lpmkn.cloudfront.net
127.0.0.1       desktop.spotify.com
127.0.0.1       doubleclick.net
127.0.0.1       ds.serving-sys.com
127.0.0.1       googleadservices.com
127.0.0.1       googleads.g.doubleclick.net
127.0.0.1       gtssl2-ocsp.geotrust.com
127.0.0.1       js.moatads.com
127.0.0.1       log.spotify.com
127.0.0.1       media-match.com
127.0.0.1       omaze.com
127.0.0.1       open.spotify.com
127.0.0.1       pagead46.l.doubleclick.net
127.0.0.1       pagead2.googlesyndication.com
127.0.0.1       partner.googleadservices.com
127.0.0.1       pubads.g.doubleclick.net
127.0.0.1       redirector.gvt1.com
127.0.0.1       s0.2mdn.net
127.0.0.1       securepubads.g.doubleclick.net
127.0.0.1       spclient.wg.spotify.com
127.0.0.1       tpc.googlesyndication.com
127.0.0.1       v.jwpcdn.com
127.0.0.1       video-ad-stats.googlesyndication.com
127.0.0.1       weblb-wg.gslb.spotify.com
127.0.0.1       www.googleadservices.com
127.0.0.1       www.googletagservices.com
127.0.0.1       www.omaze.com
```

> **Note:** Untuk daftar list yang uptodate, cek [disini][hostfile-url].

## Edit file host

**Windows user**

- Buka notepad (text editor) dengan hak akses administrator
- Buka file `C:\Windows\system32\drivers\etc\hosts`
- Tambahkan kode diatas di bagian bawah file
- Save

**Linux user**

- Buka text editor dengan hak akses superuser (sudo)
- Buka file `/etc/hosts`
- Tambahkan kode diatas pada bagian bawah file
- Save

Setelah file berhasil disimpan, sebaiknya restart Spotify kalau sebelumnya telah dibuka. Sekarang tiap kali kita mendengarkan musik dengan spotify, tidak ada lagi iklan yang mengganggu karena telah diblok dengan file host kita.

## Referensi

- https://www.reddit.com/r/Piracy/comments/4kn6rq/comprehensive_guide_to_blocking_ads_on_spotify/

[hostfile-url]: https://github.com/zackad/dotfiles/blob/master/hosts.d/ads_spotify.conf
