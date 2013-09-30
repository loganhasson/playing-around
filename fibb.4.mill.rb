def gen_fib(num1, num2)
  num1 + num2
end

def sum_evens(array)
  sum = 0
  array.each do |item|
    sum += item if item % 2 == 0
  end
  sum
end

def make_fibs(max)
  fib_arr = [1, 1]
  until fib_arr[-1] >= max
    fib_arr << gen_fib(fib_arr[-1], fib_arr[-2])
  end
  sum_evens(fib_arr)
end

puts make_fibs(4000000)