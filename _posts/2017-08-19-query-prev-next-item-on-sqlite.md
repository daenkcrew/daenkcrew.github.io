---
layout: post
author: zackad
title: "How To Query Previous And Next Item From SQLite Table"
category: en
tags: sqlite
---
Let say we have data like this.

|id|title|
|---|---|
|1|Vessel, Landmark Baru Manhattan|
|2|Seperti Apa Rasanya Memiliki Rumah “di Bawah” Batu?|
|3|Museum Gempa Di China Berbentuk Menyerupai Retakan Tanah|
|4|Menyusuri Jejak Budaya Peranakan di Rumah Kayu Goen|
|5|Tips Agar Material Semen Ekspos Terlihat Lebih Menarik|
|6|Ciptakan Nuansa Alam Dengan Material Bata Ekspos|
|7|Mengagumi Keindahan Arsitektur Kolonial Istana Cipanas|
|8|5 Cara Atasi Masalah Plafon Melendut|
|9|Di dalam Hotel Ini Ada Batu!|
|10|Tips Memilih Papan Gipsum Yang Berkualitas|

Now we want to select an item with `id` 4 and its previous and next item from that order (off course the real order depends on our real query). We can use `union` to get the **current item** (id=4), **previous item** (id=3), and **next item** (id=5) and the query become like this

```sql
sqlite> select * from (select * from table_name where id = 4)
    union
    select * from (select * from table_name where id < 4 order by id desc limit 1)
    union
    select * from (select * from table_name where id > 4 limit 1);
```

Standard SQL doesn't permit to use `order by` and `limit` in "part" of each union. So we need to filter our query results before calling union select.

The result would be like this.

|id|title|
|---|---|
|3|Museum Gempa Di China Berbentuk Menyerupai Retakan Tanah|
|4|Menyusuri Jejak Budaya Peranakan di Rumah Kayu Goen|
|5|Tips Agar Material Semen Ekspos Terlihat Lebih Menarik|
