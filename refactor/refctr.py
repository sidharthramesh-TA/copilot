
# Input Code

import math

def a(n):
  if n > 1:
    f = 1
    for i in range(1, n+1):
      f = f * i
    return f
  elif n == 1 or n == 0:
    return 1
  else:
    return -1

def b(r):
  return math.pi * r * r

def main():
  x = 5
  y = 10
  z = a(x)
  print('Factorial of', x, 'is', z)
  c = b(y)
  print('Area of circle with radius', y, 'is', c)

main()


# Refactored code


import math

def factorial(n):
    if n > 1:
        f = 1
        for i in range(1, n+1):
            f = f * i
        return f
    elif n == 1 or n == 0:
        return 1
    else:
        return -1

def area_of_circle(r):
    return math.pi * r * r

def fibonacci(n):
    if n <= 0:
        return "Invalid input"
    elif n == 1:
        return 0
    elif n == 2:
        return 1
    else:
        a, b = 0, 1
        for i in range(2, n):
            a, b = b, a + b
        return b

def main():
    x = 5
    y = 10
    z = factorial(x)
    print('Factorial of', x, 'is', z)
    c = area_of_circle(y)
    print('Area of circle with radius', y, 'is', c)
    fib_number = fibonacci(x)
    print('Fibonacci number at position', x, 'is', fib_number)

main()
