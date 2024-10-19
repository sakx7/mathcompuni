import numpy as np

def arc_length_parabola(a, b):
    L_ABC=(1/2)*np.sqrt(b**2+16*a**2)+(b**2/(8*a))*np.log((4*a+np.sqrt(b**2+16*a**2))/b)
    return L_ABC

a = float(input("Enter the value of a (height): "))
b = float(input("Enter the value of b (width): "))

L_ABC = arc_length_parabola(a, b)

print(f"The arc length L_ABC is: {L_ABC:.2f}")
