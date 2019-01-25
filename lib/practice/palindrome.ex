defmodule Practice.Palindrome do
  def palindrome(str) do
    rev = String.reverse(str)
    if String.downcase(str) == String.downcase(rev) do
      true
    else
      false
    end
  end
end
