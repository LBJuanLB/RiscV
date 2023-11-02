def multiplicacion(num1,num2):
    if num1 < num2:
        mayor = num2
        menor = num1
    else:
        mayor = num1
        menor = num2
    i = menor
    mult=0
    while (i>0):
        print("Hola")
        mult=mult+mayor
        i=i-1
    return mult

def division_con_suma_resta(dividendo, divisor):
    if divisor == 0:
        raise ValueError("No se puede dividir por cero.")

    cociente = 0
    signo_cociente = 1 if (dividendo > 0 and divisor > 0) or (dividendo < 0 and divisor < 0) else -1
    dividendo = abs(dividendo)
    divisor = abs(divisor)

    while dividendo >= divisor:
        dividendo -= divisor
        cociente += 1

    cociente *= signo_cociente
    residuo = dividendo

    return cociente, residuo

# Ejemplo de uso:
dividendo = 17
divisor = 5

cociente, residuo = division_con_suma_resta(dividendo, divisor)

print(f"Cociente: {cociente}")
print(f"Residuo: {residuo}")
