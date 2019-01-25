defmodule Practice.Factor do
  # Factor Method
  def factor(x) do
    fact(x, 2, [])
  end

  def fact(x, f, fs) do
    cond do
      x < f -> fs
      rem(x, f) == 0 -> [f | fact(div(x, f), f, fs)]
      true -> fact(x, f + 1, fs)
    end
  end

end
