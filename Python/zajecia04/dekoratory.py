import time

def calculate_time(unit):
    def decorator(func):
        def inner(*args, **kwargs):
            try:
                if unit == "seconds":
                    begin = time.time()

                    results = func(*args, **kwargs)

                    end = time.time()

                    exec_time = round(end - begin)
                    print("Total time of" , func.__name__, "function execution in seconds: ", exec_time)

                    return results
                elif unit == "microseconds":
                    begin = time.time()

                    results = func(*args, **kwargs)

                    end = time.time()

                    exec_time = round((end - begin) * 1000)
                    print("Total time of " , func.__name__, " function execution in microseconds: ", exec_time)

                    return results
                else:
                    raise ValueError('Argument unit takes parameters: "seconds", "microseconds"')
            except ValueError as e:
                print(f"ERROR: {e}")
        return inner
    return decorator


@calculate_time(unit="microseconds")
def sum(n):
    sum = 0
    for i in range(n):
        sum += 1;
    return (sum)



s = sum(10000000)
print(s)