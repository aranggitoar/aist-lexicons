# **Leksikon AIST**

_Read in [Indonesian](https://github.com/benihyangbaik/aist-lexicons#readme), [English](https://github.com/benihyangbaik/aist-lexicons/blob/main/README.en.md), [Brazillian Portuguese](https://github.com/benihyangbaik/aist-lexicons/blob/main/README.ptbr.md)._

Proyek ini adalah perpanjangan dari [_Alkitab Interlinear Sumber Terbuka_
(**AIST**)](https://github.com/benihyangbaik/aist) yang akan menerjemahkan
[Leksikon Ibrani/Yunani Strong's, Ibrani Brown-Driver-Briggs, dan Yunani Thayer
dengan Referensi Ayat dari
MySword](https://mysword-bible.info:4443/download/getfile.php?file=strong.dct.mybible.gz).
(Kalau tidak dapat diunduh secara langsung, silahkan kunjungi halaman modul
kamus mereka
[disini](https://mysword-bible.info/download-mysword/dictionaries).

Segala informasi tambahan tentang leksikon-leksikon ini dapat Anda baca di
`./catatan/TENTANG.md`.

Leksikon AIST dapat dikutip, digunakan secara bebas, dengan memberikan atribusi
kepada [Benih Yang Baik](https://benihyangbaik.com).

## **Format JSON Leksikon AIST**

```json
{
  "H1": "<p>Original: <strong>אב</strong></p><p>Transliteration: <strong>'âb</strong></p> ...",
  "H2": "<p>Original: <strong>אב</strong></p><p>Transliteration: <strong>'ab</strong></p> ...",
  "H3": "<p>Original: <strong>אב</strong></p><p>Transliteration: <strong>'êb</strong></p> ..."
}
```

## **Perkembangan**

- ~~Data baru mulai dipersiapkan untuk dapat ditampilkan dan diterjemahkan
  melalui [_Editor Alkitab Interlinear Sederhana_ (_Interlinear Bible Simple
  Editor_,
  **IBSE**)](https://github.com/benihyangbaik/interlinear-bible-simple-editor).~~
  Data sudah siap digunakan, file-file JSON telah diverifikasi dengan
  [jsonlint.com](https://www.jsonlint.com/).
- Leksikon tidak akan diterjemahkan dengan IBSE. Keputusan ini didasari dua
  pertimbangan. Pertama, waktu yang akan dihabiskan untuk pengembangan fitur
  yang akan mengakomodasi penerjemahan leksikon akan terlalu lama. Kedua, agar
  perangkat lunak penerjemahan ini benar-benar sederhana, maka lebih baik kalau
  fungsinya memang satu saja. Sehingga kami menciptakan [_Editor Leksikon
  Alkitab Sederhana_ (_Bible Lexicon Simple Editor_,
  **BLSE**)](https://git.sr.ht/~ppook/blse).
- Perkembangan penerjemahan leksikon dapat dilihat dalam `./catatan/PERKEMBANGAN.md`.
  Sampai selesai diterjemahkan, leksikon tidak akan disertakan dalam repositori
  ini. Kalau Anda ingin berkontribusi, hubungi kami di info@benihyangbaik.com.

## **Penggunaan**

Cukup panggil `./unzip.sh` yang akan membuka arsip dengan perangkat `tar` dan
periksa isi direktori `./lexicons/`.

Karena ada kemungkinan dari pihak MySword untuk membarui file kamus mereka,
kami juga menyediakan sebuah skrip untuk mengunduh dan mengolah data dari file
kamus MySword.

Untuk menjalankan skrip ini Anda memerlukan `sqlite3`, `gzip`, `wget`, dan `dos2unix`.
Kalau Anda menggunakan perangkat lain untuk mengolah file SQLite, mengolah file zip,
mengunduh sesuatu, dan mengubah format file teks DOS/Windows menjadi Unix, cukup
ubah nama perangkat di skrip.

Anda cukup menjalankannya seperti menjalankan skrip Bash pada umumnya dengan
memanggil `./run.sh`. Anda juga dapat mengecilkan ukurannya dengan memanggil
`./zip.sh` yang akan mengkompres file dengan perangkat `tar` dan `gzip`.

## **Catatan Pengembangan**

Arsip dari MySword yang digunakan sebagai sumber ada dalam bentuk SQLite.
Sehingga sebenarnya arsip lain dari bentuk SQLite bisa diolah dengan skrip ini,
tentunya dengan beberapa perubahan.

1. Perubahan dalam variabel direktori hasil, file sumber, dan file hasil.
2. Perubahan sedikit isi `while read line; do { ... }; done < $sumber`.
