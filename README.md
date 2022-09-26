# FP10-MAC
Dieses Repository enthält eine Harwarekomponente für die Ausführung eines Multiply-Accumulate-Befehls (MAC-Befehls). Beschrieben ist die Hardwarekomponente in der Beschreibungssprache VHDL. Die entsprechenden Dateien befinden sich im Ordner 'VHDL', wobei es sich bei allen Dateien, die auf '_tb.vhdl' enden, um Testbenches der Dateien mit sonst gleichem Namen, aber der Dateiendung '.vhdl' handelt. Eine ausführliche Dokumentation der Hardwarekomponente ist mit der PDF-Datei 'Dokumentation.pdf' gegeben.

Um einen eigenen Testlauf der Hardwarekomponente durchzuführen ist der Ordner 'VHDL' herunterzuladen. Weiterhin wird vorausgesetzt, dass GHDL als Simulator für VHDL und GTKWave für eine anschließende Visualisierung der Ergebnisse installiert ist. Der einfachste Weg, den Testlauf durchzuführen besteht in der Ausführung des Python-Scipts 'main.py' im Ordner 'VHDL', woraufhin automatisch die 'work-obj93.cf' und ein weiterer Ordner 'VCD', welcher die Ergebnisse des Testlaufs als VCD-Dateien enthält, im Ordner 'VHDL' erzeugt werden.

Für eine manuelle Ausführung, mit gleichem Ergebnis, sind folgende GHDL-Befehle für alle VHDL-Dateien nacheinander innerhalb eines Kommandozeilenwerkzeugs im heruntergeladenen VHDL-Ordner auszuführen:
- 'ghdl -s <Dateiname>.vhdl',
- 'ghdl -a <Dateiname>.vhdl',
- 'ghdl -e <Dateiname>'.

Falls es sich bei der jeweiligen VHDL-Datei um eine Testbench handelt, ist anschließend jeweils der folgende GHDL-Befehl auszuführen:
- 'ghdl -r <Dateiname> --vcd=VCD\\<Dateiname>.vcd --ieee-asserts=disable'.

Da die einzelnen Bausteine der Hardwarekomponenten aufeinander ausbauen ist bei der Ausführung folgende Datei-Reihenfolge einzuhalten:
1. "and2.vhdl",
2. "brent_kung_adder8.vhdl",
3. "brent_kung_adder16.vhdl",
4. "brent_kung_processor.vhdl",
5. "complementer8.vhdl",
6. "d_ff.vhdl",
7. "dadda_reducer.vhdl",
8. "fa.vhdl",
9. "ha.vhdl",
10. "mac.vhdl",
11. "mux2_1.vhdl",
12. "not1.vhdl",
13. "or2.vhdl",
14. "pipo8.vhdl",
15. "pipo16.vhdl",
16. "xor2.vhdl",
17. "xor3.vhdl",
18. "and2_tb.vhdl",
19. "brent_kung_adder8_tb.vhdl",
20. "brent_kung_adder16_tb.vhdl",
21. "brent_kung_processor_tb.vhdl",
22. "complementer8_tb.vhdl",
23. "d_ff_tb.vhdl",
24. "dadda_reducer_tb.vhdl",
25. "fa_tb.vhdl",
26. "ha_tb.vhdl",
27. "mac_tb.vhdl",
28. "mux2_1_tb.vhdl",
29. "not1_tb.vhdl",
30. "or2_tb.vhdl",
31. "pipo8_tb.vhdl",
32. "pipo16_tb.vhdl",
33. "xor2_tb.vhdl",
34. "xor3_tb.vhdl".

Anschließend können die so erzeugten VCD-Dateien im Ordner 'VCD' mit GTKWave visualisiert werden, indem für eine Datei von Interesse der Befehl:
- 'gtkwave <Dateiname>.vcd'

innerhalb eines Kommandozeilenwerkzeugs im VCD-Ordner ausgeführt wird.
