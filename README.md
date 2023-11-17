# RiscV
Procesador RISC-V Monociclo 

Elaborado por:
- Luis Sebastian Conde Toro
- Juan Jose Espinosa Mendez

En el archivo "Instrucciones.s" se pone instrucciones en ensamblador y luego se debe ejecutar el programa "compilador_risc_v.py" para que pase las instrucciones a binario. 

Kaleidoscope toma el programa que le envies y lo transforma en instrucciones de ensamblador

Para ejecutar kaleidoscope se puede de dos formas:

Si esta en la ubicación RiscV\:                                  python comparch/kaleidoscope/plyplus/kalc2.py comparch/kaleidoscope/examples/factorial.kl Instrucciones.s

Si esta en la ubicación RiscV\comparch\kaleidoscope\plyplus:     python kalc.py ../examples/factorial.kl ../../../Instrucciones.s

Recordar ejecutar "compilador_risc_v.py" luego de modificar el archivo "Instrucciones.s" o luego de ejecutar kaleidoscope para que se genere el binario de las instrucciones


Para ejecutar la CPU nosotros utilizamos las siguientes instrucciones:

iverilog -o CPU_tb.vvp CPU_tb.v

vvp CPU_tb.vvp

y en la consola se muestra la informacion de los registros.


El programa que tiene Binario_Inst.txt es el del factorial de 7. El resultado lo arroja en el Registro 10 o a0.
