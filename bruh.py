import random
import time
for i in range(100):
    print(f"Iteration: {i+1}")
    num=random.randint(1,100)
    print(f"Random number: {num}")
    time.sleep(0.25)