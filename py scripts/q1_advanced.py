"""
Requirements to run:
    - Python 3.x (https://www.python.org/)
    - NumPy and Matplotlib (install with cmd prmp: pip install numpy matplotlib)
"""

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.widgets import Slider, Button

def arc_length_parabola(a, b):
    L_ABC=(1/2)*np.sqrt(b**2+16*a**2)+(b**2/(8*a))*np.log((4*a+np.sqrt(b**2+16*a**2))/b)
    return L_ABC

fig, ax = plt.subplots(figsize=(10, 6))
plt.subplots_adjust(left=0.1, bottom=0.3, right=0.9, top=0.9)
initial_a = 11.0
initial_b = 9.0

ax_slider_a = plt.axes([0.1, 0.15, 0.8, 0.03])
ax_slider_b = plt.axes([0.1, 0.1, 0.8, 0.03])

slider_a = Slider(ax_slider_a, 'a (height)', 0.1, 20, valinit=initial_a, valfmt='%0.2f')
slider_b = Slider(ax_slider_b, 'b (width)', 0.1, 20, valinit=initial_b, valfmt='%0.2f')

x = np.linspace(-10, 10, 1000)

def update(val):
    a = slider_a.val
    b = slider_b.val
    L_ABC = arc_length_parabola(a, b)

    ax.clear()
    # should add if a > 0 and b != 0: but im not going to since i set the slider limits accordingly
    y = -((2*np.sqrt(a))*x/b)**2 + a
    ax.plot(x, y, label=r'$y = -\left(\frac{2\sqrt{a}}{b}x\right)^2 + a$', color='blue')

    ax.vlines(0, 0, a, color='red',linewidth=2 , zorder=10, label=r'$a$ (height)')
    ax.hlines(0, -b/2, b/2, color='green',linewidth=2, zorder=10, label=r'$b$ (width)')
    
    ax.text(0.05, a/2, f'a = {a:.2f} cm', color='red', fontsize=10, verticalalignment='bottom')
    ax.text(0, 0.05, f'b = {b:.2f} cm', color='green', fontsize=10, horizontalalignment='right')

    A_x = -b/2
    C_x = b/2
    
    ax.plot(A_x, 0, 'o', zorder=10, color='purple', label=r'Point $A = (-\frac{b}{2}, 0)$')
    ax.plot(0, a, 'o',zorder=10,  color='orange', label=r'Point $B = (0, a)$')
    ax.plot(C_x, 0, 'o',zorder=10, color='purple', label=r'Point $C = (\frac{b}{2}, 0)$')
    
    ax.annotate('A', (A_x, 0), textcoords="offset points", xytext=(-5,7), ha='center', color='purple')
    ax.annotate('B', (0, a), textcoords="offset points", xytext=(10,5), ha='center', color='orange')
    ax.annotate('C', (C_x, 0), textcoords="offset points", xytext=(5,7), ha='center', color='purple')

    ax.set_title(f'Arc Length Calculation')
    ax.set_xlabel(r'$L_{ABC} = \frac{1}{2}\sqrt{' + f'({b:.2f})^2 + 16({a:.2f})^2' + r'} + \frac{' + f'({b:.2f})^2' + r'}{8(' + f'{a:.2f}' + r')}\ln\left(\frac{4(' + f'{a:.2f}' + r') + \sqrt{' + f'({b:.2f})^2 + 16({a:.2f})^2' + r'}}{' + f'{b:.2f}' + r'}\right) \approx ' + f'{L_ABC:.2f}$', size=14)

    ax.set_ylim(-1, a + 1)
    ax.set_xlim(-b/2 - 1, b/2 + 1)

    ax.legend(bbox_to_anchor=(0, 1), loc='upper left', borderaxespad=0.)
    
    ax.grid(True)
    ax.axhline(y=0, color='k', linestyle='-', linewidth=0.5)
    ax.axvline(x=0, color='k', linestyle='-', linewidth=0.5)
    plt.draw()

slider_a.on_changed(update)
slider_b.on_changed(update)

resetax = plt.axes([0.8, 0.025, 0.1, 0.04])
button = Button(resetax, 'Reset', color='lightgoldenrodyellow', hovercolor='0.975')

def reset(event):
    slider_a.reset()
    slider_b.reset()
    update(None)

button.on_clicked(reset)

update(None)

plt.savefig('images/Figure_1.png',dpi=400)
plt.show()
