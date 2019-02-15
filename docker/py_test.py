import time

count = 0
gap = 10
while True:
    count = count + 1
    print(str(count) + ". This prints once every "+ str(gap) +" secs.")
    time.sleep(gap)