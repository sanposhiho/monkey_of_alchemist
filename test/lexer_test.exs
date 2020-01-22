ExUnit.start()
defmodule LexerTest do
  use ExUnit.Case
  doctest Lexer

  test "test next token" do
    input = '=+(){},;'

    lexer = Lexer.new(input)

    [
      %Token{type: Token.token_type.assign,    literal: "="},
      %Token{type: Token.token_type.plus,      literal: "+"},
      %Token{type: Token.token_type.lparen,    literal: "("},
      %Token{type: Token.token_type.rparen,    literal: ")"},
      %Token{type: Token.token_type.lbrace,    literal: "{"},
      %Token{type: Token.token_type.rbrace,    literal: "}"},
      %Token{type: Token.token_type.comma,     literal: ","},
      %Token{type: Token.token_type.semicolon, literal: ";"},
      %Token{type: Token.token_type.eof,       literal: ""},
    ]
    |> Enum.reduce(lexer, fn %Token{type: type, literal: literal}, acc_lexer ->
      acc_lexer = acc_lexer |> Lexer.read_token()
      assert type == Enum.at(acc_lexer.result, -1).type
      assert literal == Enum.at(acc_lexer.result, -1).literal
      acc_lexer
    end)
  end
end
