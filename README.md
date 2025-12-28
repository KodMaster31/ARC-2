🚀 ARC-2: Soyut İndirgenmiş Bilgisayar Mimarisi ve Simülasyonu
[Proje Hakkında] Bu çalışma, bilgisayar mimarisinin en temel bileşenlerini anlamak ve simüle etmek amacıyla geliştirilmiş bir Abstract Reduced Computer (ARC) ekosistemidir. Proje, donanım seviyesindeki Verilog tasarımlarından, yüksek seviyeli C simülatörlerine ve düşük seviyeli x86_64 Assembly uygulamalarına kadar geniş bir yelpazeyi kapsar. Temel odak noktası, 1-bit ve 2-bit işlemci mimarilerinde veri işleme, komut döngüleri (fetch-decode-execute) ve bellek yönetimini somutlaştırmaktır.

📂 Proje Bileşenleri ve Yapısı
Proje içerisinde yer alan dosyalar, işlemci tasarımının farklı aşamalarını temsil etmektedir:

Donanım Tanımlama (Verilog): arc01.asm ve arch02.asm dosyaları, 1-bitlik akümülatör ve 2-bitlik program sayacına sahip temel işlemci modellerini içerir. arc03.asm ise dallanma (JMP/JZ) ve karşılaştırma (CMP) yeteneklerine sahip daha gelişmiş bir 2-bitlik mimariyi sunar.

Yazılım Simülatörleri (C): arc.c ve arc2.c dosyaları, tasarlanan bu mimarilerin çalışma mantığını modern sistemlerde test etmek için yazılmıştır. Bu simülatörler, standart girdiden gelen komutları yorumlayarak akümülatör üzerindeki değişimleri ve bellek durumlarını raporlar.

Düşük Seviye Mantık (Assembly): arc.asm dosyası, x86_64 mimarisi üzerinde bu soyut işlemci döngüsünü taklit eden bir örnekleme içerir.

⚙️ Komut Seti ve Çalışma Prensibi (ISA)
İşlemcilerimiz, karmaşıklığı azaltmak adına optimize edilmiş bir komut seti kullanmaktadır. Temel işlemler şunlardır:

[!IMPORTANT] LOAD (00): Veriyi bellekten akümülatöre taşır. ADD/AND (01): Akümülatördeki veri üzerinde aritmetik veya mantıksal işlem yapar. STORE (10): Sonucu belirlenen bellek adresine kaydeder. CONTROL (11): Program akışını yönlendiren (JMP, JZ, OUT, HALT) kritik komutları icra eder.

🛠 Kurulum ve Kullanım Guide
[C Simülatörünü Derleme] Yazılım tabanlı simülatörü test etmek için aşağıdaki adımları izleyebilirsiniz:

Bash

# Simülatörü derleyin
gcc arc2.c -o arc_sim

# Örnek bir program koşturun (LOAD 1, ADD 2, OUT)
echo "LOAD 1 ADD 2 OUT 0 ." | ./arc_sim
[Verilog Simülasyonu] Donanım dosyalarını (.asm uzantılı ancak Verilog içeriğine sahip dosyalar) Icarus Verilog veya benzeri bir araçla derleyerek dalga formu (waveform) analizleri yapabilirsiniz.

📜 Lisans Bilgisi
Bu projenin tüm hakları, özgür yazılım prensiplerini desteklemek adına GNU General Public License v3.0 (GPL-3.0) ile korunmaktadır. Proje içeriğini bu lisans dahilinde kopyalayabilir, değiştirebilir ve dağıtabilirsiniz.

[Katkıda Bulunma] Eğer yeni bir komut eklemek veya mimariyi 4-bit seviyesine taşımak isterseniz, lütfen bir Pull Request açmaktan çekinmeyin!
