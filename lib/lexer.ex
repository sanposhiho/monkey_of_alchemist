defmodule Lexer do
  defstruct [:input, :ch, position: 0, read_position: 1, result: []]

  def new(input) do
    ch = Enum.at(input, 0)
    %Lexer{input: input, ch: [ch]}
  end

  def read_token(lexer) do
    new_token =
      case lexer.ch do
        '=' -> Token.new(Token.token_type.assign,    to_string(lexer.ch))
        ';' -> Token.new(Token.token_type.semicolon, to_string(lexer.ch))
        '(' -> Token.new(Token.token_type.lparen,    to_string(lexer.ch))
        ')' -> Token.new(Token.token_type.rparen,    to_string(lexer.ch))
        ',' -> Token.new(Token.token_type.comma,     to_string(lexer.ch))
        '+' -> Token.new(Token.token_type.plus,      to_string(lexer.ch))
        '{' -> Token.new(Token.token_type.lbrace,    to_string(lexer.ch))
        '}' -> Token.new(Token.token_type.rbrace,    to_string(lexer.ch))
        nil -> Token.new(Token.token_type.eof,       "")
      end

    lexer
    |> Map.update!(:result, fn result -> result ++ [new_token] end)
    |> update_lexer()
  end

  defp update_lexer(lexer) do
    if lexer.read_position >= String.length(to_string(lexer.input)) do
      lexer
      |> Map.update!(:ch, fn _ch -> nil end)
    else
      lexer
      |> Map.update!(:ch, fn _l -> [Enum.at(lexer.input, lexer.read_position)]  end)
      |> Map.update!(:position, &(&1 + 1))
      |> Map.update!(:read_position, &(&1 + 1))
    end
  end

end
