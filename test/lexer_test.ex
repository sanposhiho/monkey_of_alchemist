defmodule LexerTest do
  use ExUnit.Case
  doctest Lexer

  test "test next token" do
    input = "=+(){},;"

    lexer = Lexer.new(input)

    [
      %Token{type: tokentype.assign,    literal: "="},
      %Token{type: tokentype.plus,      literal: "+"},
      %Token{type: tokentype.lparen,    literal: "("},
      %Token{type: tokentype.rparen,    literal: ")"},
      %Token{type: tokentype.lbrace,    literal: "{"},
      %Token{type: tokentype.rbrace,    literal: "}"},
      %Token{type: tokentype.comma,     literal: ","},
      %Token{type: tokentype.semicolon, literal: ";"},
      %Token{type: tokentype.eof,       literal: ""},
    ]
    |> Enum.each(fn %Token{type: type, literal: literal}, lexer ->
      lexer = lexer |> Lexer.next_token()
      assert type == Enum.at(lexer.result.type, -1)
      assert literal == Enum.at(lexer.result.literal, -1)
      lexer
    end)
