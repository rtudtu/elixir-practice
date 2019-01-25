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

  def eval(toks) do
    eval_help(toks, ["*", "/", "+", "-"], 0)
  end

  def eval_help(toks, ops, i) do
    cond do
      length(toks) == 1 && length(ops) == 0 -> List.first(toks) |> elem(1)
      i >= length(toks) -> eval_help(toks, List.delete_at(ops, 0), 0)
      Enum.at(toks, i) |> elem(1) == List.first(ops) -> 
        eval_help(evaluate(toks, i), ops, 0)
      true -> eval_help(toks, ops, i + 1)
    end
  end

  def evaluate(toks, i) do
    num1 = Enum.at(toks, i - 1) |> elem(1)
    num2 = Enum.at(toks, i + 1) |> elem(1)
    op = Enum.at(toks, i) |> elem(1)
    toks = List.delete_at(toks, i + 1)
    toks = List.delete_at(toks, i)
    toks = List.delete_at(toks, i - 1)
    cond do
      op == "*" -> List.insert_at(toks, i - 1, {:num, num1 * num2})
      op == "/" -> List.insert_at(toks, i - 1, {:num, num1 / num2})
      op == "+" -> List.insert_at(toks, i - 1, {:num, num1 + num2})
      op == "-" -> List.insert_at(toks, i - 1, {:num, num1 - num2})
    end  
  end

  def calc(expr) do
    expr
    |> String.split(~r/\s+/)
    |> tag_tokens
    |> eval
  end
end
