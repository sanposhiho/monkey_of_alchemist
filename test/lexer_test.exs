defmodule LexerTest do
  use ExUnit.Case
  doctest Lexer

  test "test lexer2" do
    input =
     'let five = 5;
      let ten = 10;

      let add = fn(x, y) {
        x + y;
      };

      let result = add(five, ten);
      !-/*5;
      5 < 10 > 5;

      if (5 < 10) {
        return true;
      }else{
        return false;
      }

      10 == 10;
      10 != 9;'

    lexer = Lexer.new(input)

    [
      %Token{type: Token.token_type.let,        literal: "let"},
      %Token{type: Token.token_type.ident,      literal: "five"},
      %Token{type: Token.token_type.assign,     literal: "="},
      %Token{type: Token.token_type.int,        literal: "5"},
      %Token{type: Token.token_type.semicolon,  literal: ";"},
      %Token{type: Token.token_type.let,        literal: "let"},
      %Token{type: Token.token_type.ident,      literal: "ten"},
      %Token{type: Token.token_type.assign,     literal: "="},
      %Token{type: Token.token_type.int,        literal: "10"},
      %Token{type: Token.token_type.semicolon,  literal: ";"},
      %Token{type: Token.token_type.let,        literal: "let"},
      %Token{type: Token.token_type.ident,      literal: "add"},
      %Token{type: Token.token_type.assign,     literal: "="},
      %Token{type: Token.token_type.function,   literal: "fn"},
      %Token{type: Token.token_type.lparen,     literal: "("},
      %Token{type: Token.token_type.ident,      literal: "x"},
      %Token{type: Token.token_type.comma,      literal: ","},
      %Token{type: Token.token_type.ident,      literal: "y"},
      %Token{type: Token.token_type.rparen,     literal: ")"},
      %Token{type: Token.token_type.lbrace,     literal: "{"},
      %Token{type: Token.token_type.ident,      literal: "x"},
      %Token{type: Token.token_type.plus,       literal: "+"},
      %Token{type: Token.token_type.ident,      literal: "y"},
      %Token{type: Token.token_type.semicolon,  literal: ";"},
      %Token{type: Token.token_type.rbrace,     literal: "}"},
      %Token{type: Token.token_type.semicolon,  literal: ";"},
      %Token{type: Token.token_type.let,        literal: "let"},
      %Token{type: Token.token_type.ident,      literal: "result"},
      %Token{type: Token.token_type.assign,     literal: "="},
      %Token{type: Token.token_type.ident,      literal: "add"},
      %Token{type: Token.token_type.lparen,     literal: "("},
      %Token{type: Token.token_type.ident,      literal: "five"},
      %Token{type: Token.token_type.comma,      literal: ","},
      %Token{type: Token.token_type.ident,      literal: "ten"},
      %Token{type: Token.token_type.rparen,     literal: ")"},
      %Token{type: Token.token_type.semicolon,  literal: ";"},
      %Token{type: Token.token_type.bang,       literal: "!"},
      %Token{type: Token.token_type.minus,      literal: "-"},
      %Token{type: Token.token_type.slash,      literal: "/"},
      %Token{type: Token.token_type.asterisk,   literal: "*"},
      %Token{type: Token.token_type.int,        literal: "5"},
      %Token{type: Token.token_type.semicolon,  literal: ";"},
      %Token{type: Token.token_type.int,        literal: "5"},
      %Token{type: Token.token_type.lt,         literal: "<"},
      %Token{type: Token.token_type.int,        literal: "10"},
      %Token{type: Token.token_type.gt,         literal: ">"},
      %Token{type: Token.token_type.int,        literal: "5"},
      %Token{type: Token.token_type.semicolon,  literal: ";"},
      %Token{type: Token.token_type.if,         literal: "if"},
      %Token{type: Token.token_type.lparen,     literal: "("},
      %Token{type: Token.token_type.int,        literal: "5"},
      %Token{type: Token.token_type.lt,         literal: "<"},
      %Token{type: Token.token_type.int,        literal: "10"},
      %Token{type: Token.token_type.rparen,     literal: ")"},
      %Token{type: Token.token_type.lbrace,     literal: "{"},
      %Token{type: Token.token_type.return,     literal: "return"},
      %Token{type: Token.token_type.true,       literal: "true"},
      %Token{type: Token.token_type.semicolon,  literal: ";"},
      %Token{type: Token.token_type.rbrace,     literal: "}"},
      %Token{type: Token.token_type.else,       literal: "else"},
      %Token{type: Token.token_type.lbrace,     literal: "{"},
      %Token{type: Token.token_type.return,     literal: "return"},
      %Token{type: Token.token_type.false,      literal: "false"},
      %Token{type: Token.token_type.semicolon,  literal: ";"},
      %Token{type: Token.token_type.rbrace,     literal: "}"},
      %Token{type: Token.token_type.int,        literal: "10"},
      %Token{type: Token.token_type.eq,         literal: "=="},
      %Token{type: Token.token_type.int,        literal: "10"},
      %Token{type: Token.token_type.semicolon,  literal: ";"},
      %Token{type: Token.token_type.int,        literal: "10"},
      %Token{type: Token.token_type.not_eq,     literal: "!="},
      %Token{type: Token.token_type.int,        literal: "9"},
      %Token{type: Token.token_type.semicolon,  literal: ";"},
      %Token{type: Token.token_type.eof,        literal: ""},
    ]
    |> Enum.reduce(lexer, fn %Token{type: type, literal: literal}, acc_lexer ->
      acc_lexer = acc_lexer |> Lexer.read_token()
      assert type == Enum.at(acc_lexer.result, -1).type
      assert literal == Enum.at(acc_lexer.result, -1).literal
      acc_lexer
    end)
  end
end
