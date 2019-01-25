defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def tag_token(tok) do
    cond do
      Enum.member?(["+", "-", "*", "/"], tok) -> {:op, tok}
      true -> {:num, parse_float(tok)}
    end
  end

  def tag_tokens(toks) do
    Enum.map(toks, fn(tok) -> tag_token(tok) end)
  end

  def eval_mul_div([{:num, num1}, {:op, "*"}, {:num, num2} | rest]) do
    #[{:num, num1 * num2}] ++ eval_mul_div(rest)
    eval_mul_div([{:num, num1 * num2}] ++ rest)
  end

  def eval_mul_div([{:num, num1}, {:op, "/"}, {:num, num2} | rest]) do
    #[{:num, num1 / num2}] ++ eval_mul_div(rest)
    eval_mul_div([{:num, num1 / num2}] ++ rest)
  end

  def eval_mul_div([first | rest]) do
    [first] ++ eval_mul_div(rest)
  end

  def eval_mul_div([]) do
    []
  end
  
  def eval_add_sub([{:num, num1}, {:op, "+"}, {:num, num2} | rest]) do
    #[{:num, num1 + num2}] ++ eval_add_sub(rest)
    eval_add_sub([{:num, num1 + num2}] ++ rest)
  end

  def eval_add_sub([{:num, num1}, {:op, "-"}, {:num, num2} | rest]) do
    #[{:num, num1 - num2}] ++ eval_add_sub(rest)
    eval_add_sub([{:num, num1 - num2}] ++ rest)
  end

  def eval_add_sub([first | rest]) do
    [first] ++ eval_add_sub(rest)
  end

  def eval_add_sub([]) do
    []
  end

  def calc(expr) do
    expr
    |> String.split(~r/\s+/)
    |> tag_tokens
    |> eval_mul_div
    |> eval_add_sub
    |> hd
    |> elem(1)
  end
end
