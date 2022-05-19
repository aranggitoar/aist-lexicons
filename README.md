# **Leksikon AIST**
*Read in [Indonesian](https://github.com/benihyangbaik/aist-lexicons#readme), [English](https://github.com/benihyangbaik/aist-lexicons/blob/main/README.en.md), [Brazillian Portuguese](https://github.com/benihyangbaik/aist-lexicons/blob/main/README.ptbr.md).*

Proyek ini adalah perpanjangan dari [*Alkitab Interlinear Sumber Terbuka*
(**AIST**)](https://github.com/benihyangbaik/aist) yang akan menerjemahkan
[Leksikon Ibrani/Yunani Strong's, Ibrani Brown-Driver-Briggs, dan Yunani Thayer
dengan Referensi Ayat dari
MySword](https://mysword-bible.info:4443/download/getfile.php?file=strong.dct.mybible.gz).
(Kalau tidak dapat diunduh secara langsung, silahkan kunjungi halaman modul
kamus mereka
[disini](https://mysword-bible.info/download-mysword/dictionaries).

Leksikon AIST dapat dikutip, digunakan secara bebas, dengan memberikan atribusi
kepada [Benih Yang Baik](https://benihyangbaik.com).

## **Perkembangan**
- ~~Data baru mulai dipersiapkan untuk dapat ditampilkan dan diterjemahkan
  melalui [*Editor Alkitab Interlinear Sederhana* (*Interlinear Bible Simple
  Editor*,
  **IBSE**)](https://github.com/benihyangbaik/interlinear-bible-simple-editor).~~
  Data sudah siap digunakan.
- Skrip sudah siap digunakan untuk mengambil dan mengolah data.

## **Penggunaan**
Karena ada kemungkinan dari pihak MySword untuk membarui file kamus mereka, daripada
menyediakan data yang telah diolah, kami menyediakan sebuah skrip untuk
mengunduh dan mengolah data dari file kamus MySword.

Untuk menjalankan skrip ini Anda memerlukan `sqlite3`, `gzip`, `wget`, dan `dos2unix`.
Kalau Anda menggunakan perangkat lain untuk mengolah file SQLite, mengolah file zip,
mengunduh sesuatu, dan mengubah format file teks DOS/Windows menjadi Unix cukup
ubah nama perangkat di skrip.

Anda cukup menjalankannya seperti menjalankan skrip Bash pada umumnya dengan
memanggil `./run.sh`.
