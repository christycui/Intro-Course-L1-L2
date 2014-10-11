def fib(n)
  if n == 1
    fib = 1
  elsif n ==2
    fib = 2
  else
    fib = fib(n-2) + fib(n-1)
  end
end



def fib2(n)
  if n < 3
    n
  else
    pointer1 = 1
    pointer2 = 2
    i = 3
    while (i <= n)
      temp = pointer1 + pointer2
      pointer1 = pointer2
      pointer2 = temp
      i += 1
    end
    pointer2
  end
end

p fib2(5)