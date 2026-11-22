# ARC-2

1-bit ve 2-bit seviyesinde çalışan küçük bir soyut CPU / sanal makine denemesi. Amaç fetch-decode-execute döngüsünü, register ve bellek davranışını farklı katmanlarda yan yana görmek: Verilog donanım modeli, C simülatörü ve x86_64 assembly karşılığı.

## Repo Yapısı

- **Verilog:** `arc01.asm`, `arch02.asm`, `arc03.asm` — isimleri `.asm` olsa da içerikleri Verilog modülleri. 1-bit `acc` ve 2-bit `pc` ile başlayan temel modelden dallanma (`JMP`/`JZ`) ve karşılaştırma (`CMP`) eklenmiş 2-bit sürüme doğru ilerliyor.
- **C Simülatörü:** `arc.c`, `arc2.c` — `stdin`'den gelen komutları okuyup `acc`, `pc` ve bellek üzerindeki etkisini çalıştıran basit simülatörler.
- **Assembly:** `arc.asm` — x86_64 tarafında aynı mantığı taklit eden örnek.

## ISA Özeti

2-bit opcode mantığıyla çalışır (sürümlere göre tam eşleşme farkları olabilir):

- `00` — `LOAD`: Bellekten veya argümandan `acc`'ye değer alır.
- `01` — `ADD` / `AND`: `acc` üzerinde aritmetik veya mantıksal işlem yapar.
- `10` — `STORE`: `acc` değerini belleğe yazar.
- `11` — Kontrol komutları (`JMP`, `JZ`, `OUT`, `HALT` vb.).

## Kullanım

### C Simülatörü

```bash
gcc arc2.c -o arc_sim
echo "LOAD 1 ADD 2 OUT 0 ." | ./arc_sim
